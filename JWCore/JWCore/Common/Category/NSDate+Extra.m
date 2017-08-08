//
//  NSDate+Extra.m
//  StepMoney
//
//  Created by JayWong on 16/4/22.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "NSDate+Extra.h"
#import "NSString+Extra.h"

@implementation NSDate(Extra)

/**
 *  是否星期六
 */
+(BOOL)isSaturday{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger weekday=[comps weekday];
    if (weekday==7) {
        return YES;
    }
    return NO;
}

/**
 *  是否同一天
 */
+(BOOL)isSameDayWithDate:(NSDate *)date{
    NSString * dateString=[NSString dateToStringYMD:date];
    NSString * nowDateString=[NSString dateToStringYMD:[NSDate date]];
    if (date&&[dateString isEqualToString:nowDateString])return YES;
    return NO;
}

/**
 *  NSString转NSDate (yyyy-MM-dd)
 */
+(NSDate *)StringYMDToDate:(NSString *)string{
    NSDateFormatter * format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    return [format dateFromString:string];
}

/**
 *  凌晨零点零分零秒
 */
+(NSDate *)zeroDate{
    return [NSDate StringYMDToDate:[NSString dateToStringYMD:[NSDate date]]];
}

@end
