//
//  UIDevice+Extra.h
//  VTCore
//
//  Created by mk on 13-9-12.
//  Copyright (c) 2013年 app1580.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,IOS) { IOS9=9, IOS8=8,IOS7 = 7,IOS6 = 6 };

@interface UIDevice (Extra)

/*!
 * return the int value of the current version 
 * if the version like 6.1.3 will return 6
 */
+(int)iosVersion;

+(NSString *)iosVersionString;

/*!
 * will return YES if the IOSV is greater than system version
 * @param IOSV the version will test
 */
+(BOOL)isGreaterSystemVersion:(int)iosVersion;

/*!
 * will return YES if the IOSV is greater or equals with system version
 * @param IOSV the version will test
 */

+(BOOL)isGreaterOrEqualSystemVersion:(int)iosVersion;

+(UIInterfaceOrientation)deviceOrientation;

+(NSString *)deviceType;

+(NSString *)deviceUserName;

+(NSString *)deviceVersion;

+(NSString *)deviceSystemName;

+(NSString *)deviceSystemModel;

+ (BOOL)is64bit;

+ (NSString *)getCurrentDeviceModel;

@end
