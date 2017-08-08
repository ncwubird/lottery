//
//  NSDate+Extra.h
//  StepMoney
//
//  Created by JayWong on 16/4/22.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Extra)

/**
 *  是否星期六
 */
+(BOOL)isSaturday;

/**
 *  是否同一天
 */
+(BOOL)isSameDayWithDate:(NSDate *)date;

/**
 *  NSString转NSDate (yyyy-MM-dd)
 */
+(NSDate *)StringYMDToDate:(NSString *)string;

/**
 *  凌晨零点零分零秒
 */
+(NSDate *)zeroDate;

@end
