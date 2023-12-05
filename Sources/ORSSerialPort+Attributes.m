// 
// ORSSerialPort+Attributes.m
// 
//
// Created by Michael Crawford on 12/5/23.
// Using Swift 5.0
//
// Copyright © 2021 Crawford Design Engineering, LLC. All rights reserved.
//

#import <IOKit/usb/USBSpec.h>
#import "ORSSerial/ORSSerial.h"
#import "ORSSerial/ORSSerialPort+Attributes.h"

@implementation ORSSerialPort (Attributes)

- (NSDictionary *)ioDeviceAttributes
{
    NSDictionary *result = nil;

    io_iterator_t iterator = 0;

    if (IORegistryEntryCreateIterator(self.IOKitDevice,
                                      kIOServicePlane,
                                      kIORegistryIterateRecursively + kIORegistryIterateParents,
                                      &iterator) != KERN_SUCCESS) return nil;

    io_object_t device = 0;
    while ((device = IOIteratorNext(iterator)) && result == nil)
    {
        CFMutableDictionaryRef usbProperties = 0;
        if (IORegistryEntryCreateCFProperties(device, &usbProperties, kCFAllocatorDefault, kNilOptions) != KERN_SUCCESS)
        {
            IOObjectRelease(device);
            continue;
        }
        NSDictionary *properties = CFBridgingRelease(usbProperties);

        NSNumber *vendorID = properties[(__bridge NSString *)CFSTR(kUSBVendorID)];
        NSNumber *productID = properties[(__bridge NSString *)CFSTR(kUSBProductID)];
        if (!vendorID || !productID) { IOObjectRelease(device); continue; } // not a USB device

        result = properties;

        IOObjectRelease(device);
    }

    IOObjectRelease(iterator);
    return result;
}

- (NSNumber *)productID
{
    return [self ioDeviceAttributes][(__bridge NSString *)CFSTR(kUSBProductID)];
}

- (NSNumber *)vendorID
{
    return [self ioDeviceAttributes][(__bridge NSString *)CFSTR(kUSBVendorID)];
}

@end
