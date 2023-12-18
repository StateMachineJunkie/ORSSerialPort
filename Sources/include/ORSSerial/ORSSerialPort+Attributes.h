// 
// ORSSerialPort+Attributes.h
//
//
// Created by Michael Crawford on 12/5/23.
// Using Swift 5.0
//
// Copyright © 2021 Crawford Design Engineering, LLC. All rights reserved.
//

@interface ORSSerialPort (Attributes)

@property (nonatomic, readonly, nullable) NSDictionary *ioDeviceAttributes;
@property (nonatomic, readonly, nullable) NSNumber *productID;
@property (nonatomic, readonly, nullable) NSNumber *vendorID;

@end
