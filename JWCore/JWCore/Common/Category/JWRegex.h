//
//  JWRegex.h
//  JWCore
//
//  Created by JayWong on 16/5/30.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWRegex : NSObject

/**
 *  校验密码强度
 *  @description 密码的强度必须是包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间。
 */
+(BOOL)regexPassword:(NSString *)string;

/**
 *  校验邮箱
 */
+(BOOL)regexEmail:(NSString *)string;

/**
 *  校验手机号
 */
+(BOOL)regexCellphoneNo:(NSString *)string;

/**
 *  校验身份证号
 */
+(BOOL)regexIdentityCard:(NSString *)string;

/**
 *  校验日期
 *  @description “yyyy-mm-dd“ 格式的日期校验
 */
+(BOOL)regexDateFormatYMD:(NSString *)string;

/**
 *  校验金额
 *  @description 金额校验，精确到2位小数。
 */
+(BOOL)regexDecimalTwoPoint:(NSString *)string;
/**
 *  校验银行卡
 
 */

+ (BOOL) checkBankCardNumber: (NSString *)bankCardNumber;
@end
