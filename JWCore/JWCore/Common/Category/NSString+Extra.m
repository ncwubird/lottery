//
//  NSString+Extra.m
//  VTCore
//
//  Created by mk on 13-2-20.
//  Copyright (c) 2013年 app1580.com. All rights reserved.
//

#import "NSString+Extra.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (Extra)

- (UIColor *)hexColor
{
	return [self hexColorAlpha:1.0];
}

- (UIColor *)hexColorAlpha:(float)alpha
{
	NSString *hex = self;

	if ([hex characterAtIndex:0] == '#') {
		hex = [hex substringFromIndex:1];
	}

	NSString	*rs = [hex substringWithRange:NSMakeRange(0, 2)];
	long		r	= strtol([rs UTF8String], NULL, 16);
	NSString	*gs = [hex substringWithRange:NSMakeRange(2, 2)];
	long		g	= strtol([gs UTF8String], NULL, 16);
	NSString	*bs = [hex substringWithRange:NSMakeRange(4, 2)];
	long		b	= strtol([bs UTF8String], NULL, 16);
	return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}

- (UIImage *)image
{
	return [UIImage imageNamed:self];
}

+(NSString *) md5_16bits: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    NSString * resultString=[[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                              result[0], result[1], result[2], result[3],
                              result[4], result[5], result[6], result[7],
                              result[8], result[9], result[10], result[11],
                              result[12], result[13], result[14], result[15],
                              result[16], result[17], result[18], result[19],
                              result[20], result[21], result[22], result[23],
                              result[24], result[25], result[26], result[27],
                              result[28], result[29], result[30], result[31]
                              ] lowercaseString];
    return [resultString substringToIndex:16];
}

+(BOOL)isEmptyString:(NSString *)string{
    if (string==nil||[string isEqualToString:@""]||[string isEqualToString:@"NULL"]||[string isEqualToString:@"null"]) {
        return YES;
    }
    return NO;
}

+(NSString *)randomStringWithLength:(NSInteger)length;{
    char data[length];
    for (int x=0;x<length;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

+(NSString *)dateToStringYMD:(NSDate *)date{
    NSDateFormatter * format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    return [format stringFromDate:date];
}

+(NSString *)dateToStringYMD_ZN:(NSDate *)date{
    NSDateFormatter * format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    return [format stringFromDate:date];
}

+(NSString *)dateToStringYMDHMS:(NSDate *)date{
    NSDateFormatter * format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [format stringFromDate:date];
}

@end

