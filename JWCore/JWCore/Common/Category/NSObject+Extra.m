//
//  NSObject+Extra.m
//  VTCore
//
//  Created by mk on 13-2-20.
//  Copyright (c) 2013年 app1580.com. All rights reserved.
//

#import "NSObject+Extra.h"

@implementation NSObject (Extra)

- (id)toArray
{
	if ([self isKindOfClass:[NSArray class]]) {
		return self;
	}

	return [NSArray array];
}

- (id)toDict
{
	if ([self isKindOfClass:[NSDictionary class]]) {
		return self;
	}

	return [NSDictionary dictionary];
}

- (id)checkShowdataWithType:(__unsafe_unretained Class)cls
{
	if ([self isKindOfClass:cls]) {
		return self;
	}

	return [[cls alloc] init];
}

- (BOOL)isArray
{
	return [self isKindOfClass:[NSArray class]];
}

- (BOOL)isDictionary
{
	return [self isKindOfClass:[NSDictionary class]];
}

- (long)hashLongValue
{
	@try {
		NSString	*desc	= [NSString stringWithFormat:@"%@", self];
		NSRange		start	= [desc rangeOfString:@"0x"];
		NSString	*hexStr = [desc substringFromIndex:start.location];
		hexStr = [hexStr substringToIndex:[hexStr rangeOfString:@">"].location];
		return strtoul([hexStr UTF8String], 0, 16);
	} @catch(NSException *exception) {
		return 0;
	}
}

-(void)archiverWithKey:(NSString *)key data:(id)data{
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:archiveData forKey:key];
}

-(id)unarchiverWithKey:(NSString *)key{
    NSData *archivedDta = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData: archivedDta];
}

@end

