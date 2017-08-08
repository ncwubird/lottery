//
//  NSDictionary+Extra.m
//  VTCore
//
//  Created by mk on 13-2-20.
//  Copyright (c) 2013年 app1580.com. All rights reserved.
//

#import "NSDictionary+Extra.h"

@implementation NSDictionary (Extra)

- (id)objectForPath:(NSString *)path {
    NSArray *allPath = [path componentsSeparatedByString:@"/"];
    id tmpValue = self;
    for (NSString *p in allPath) {
        //判断取数组
        if ([[[NSNumber numberWithInt:[p intValue]] stringValue] isEqualToString:p]) {
            tmpValue = [tmpValue objectAtIndex:[p intValue]];
        } else if ([tmpValue isKindOfClass:[NSDictionary class]]) {
            tmpValue = [tmpValue valueForKey:p];
        }
        if ([[NSNull null] isEqual:tmpValue]||tmpValue==nil) {
            tmpValue = @"";
            break;
        }
    }
    return tmpValue;

}

- (NSString *)objectForKeyAndNull:(NSString *)key {
    NSString * value = [NSString stringWithFormat:@"%@",[self objectForPath:key]];
    if ([[NSNull null] isEqual:value] || value==nil||[value isEqualToString:@"(null)"]||[value isEqualToString:@"<null>"]||[value isEqualToString:@"null"]) {
        return @"";
    }
    return value;
}

- (BOOL)boolValueForKey:(NSString *)key {
    return [self boolValueForKey:key defaultValue:NO];
}

- (BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForPath:key] == [NSNull null] ? defaultValue
            : [[self objectForPath:key] boolValue];
}

- (int)intValueForKey:(NSString *)key {
    return [self intValueForKey:key defaultValue:0];
}

- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    return [self objectForPath:key] == [NSNull null]
    ? defaultValue : [[self objectForPath:key] intValue];
}

- (float)floatValueForKey:(NSString *)key {
    return [self floatValueForKey:key defaultValue:0];
}

- (float)floatValueForKey:(NSString *)key defaultValue:(float)defaultValue {
    return [self objectForPath:key] == [NSNull null]
    ? defaultValue : [[self objectForPath:key] floatValue];
}

@end
