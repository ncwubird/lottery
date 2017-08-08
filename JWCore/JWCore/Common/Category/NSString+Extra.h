//
//  NSString+Extra.h
//  VTCore
//
//  Created by mk on 13-2-20.
//  Copyright (c) 2013年 app1580.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *    字符串的扩展
 *    @author mk
 */
@interface NSString (Extra)

/**
 *    获取字符串的16进制的颜色
 *    @returns 颜色值
 */
- (UIColor *)hexColor;

/**
 *    获取带透明度的颜色
 *    @param alpha 透明度
 *    @returns 颜色值
 */
- (UIColor *)hexColorAlpha:(float)alpha;

/**
 *    [UIImage imageNamed:@""] 简写
 *    @returns 返回图片
 */
- (UIImage *)image;
/**
 *  MD5加密
 */
+(NSString *) md5_16bits: (NSString *) inPutText;

/**
 *  字符串是否为空
 */
+(BOOL)isEmptyString:(NSString *)string;

/**
 *  产生随机字符串
 *  @param length 字符串长度
 *  @returns 生成的字符串
 */
+(NSString *)randomStringWithLength:(NSInteger)length;

/**
 *  NSDate转化NSString:yyyy-MM-dd
 */
+(NSString *)dateToStringYMD:(NSDate *)date;

/**
 *  NSDate转化NSString:yyyy年MM月dd日
 */
+(NSString *)dateToStringYMD_ZN:(NSDate *)date;

/**
 *  NSDate转化NSString:yyyy-MM-dd HH:mm:ss
 */
+(NSString *)dateToStringYMDHMS:(NSDate *)date;

@end

