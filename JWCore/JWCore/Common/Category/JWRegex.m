//
//  JWRegex.m
//  JWCore
//
//  Created by JayWong on 16/5/30.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "JWRegex.h"

@implementation JWRegex

+(BOOL)regexPassword:(NSString *)string{
    NSString *regex = @"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$";
    return [JWRegex resultWithRegex:regex string:string];
}

+(BOOL)regexCellphoneNo:(NSString *)string{
    NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
    return [JWRegex resultWithRegex:regex string:string];
}

+(BOOL)regexIdentityCard:(NSString *)string{
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [JWRegex resultWithRegex:regex string:string];
}

+(BOOL)regexEmail:(NSString *)string{
    NSString *regex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    return [JWRegex resultWithRegex:regex string:string];
}

+(BOOL)regexDateFormatYMD:(NSString *)string{
    NSString *regex = @"^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$";
    return [JWRegex resultWithRegex:regex string:string];
}

+(BOOL)regexDecimalTwoPoint:(NSString *)string{
    NSString *regex = @"^[0-9]+(.[0-9]{2})?$";
    return [JWRegex resultWithRegex:regex string:string];
}

+(BOOL)resultWithRegex:(NSString *)regex string:(NSString *)string{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
+ (BOOL) checkBankCardNumber: (NSString *)bankCardNumber
{
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL isMatch = [pred evaluateWithObject:bankCardNumber];
    return isMatch;
}


@end
