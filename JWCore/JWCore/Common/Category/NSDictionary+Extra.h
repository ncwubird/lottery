//
//  NSDictionary+Extra.h
//  VTCore
//
//  Created by mk on 13-2-20.
//  Copyright (c) 2013年 app1580.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extra)

- (id)objectForPath:(NSString *)aPath;

- (NSString *)objectForKeyAndNull:(NSString *)key;

- (BOOL)boolValueForKey:(NSString *)key;

- (int)intValueForKey:(NSString *)key;

- (float)floatValueForKey:(NSString *)key;

- (float)floatValueForKey:(NSString *)key defaultValue:(float)defaultValue;

@end
