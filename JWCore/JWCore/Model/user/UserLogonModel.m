//
//  UserLogonModel.m
//  JWCore
//
//  Created by JayWong on 16/9/9.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "UserLogonModel.h"

@implementation UserLogonModel

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.token = [coder decodeObjectForKey:@"token"];
        self.user_id=[coder decodeObjectForKey:@"user_id"];
        self.url=[coder decodeObjectForKey:@"url"];
        self.uinfo=[coder decodeObjectForKey:@"uinfo"];
        self.homeModel=[coder decodeObjectForKey:@"homeModel"];
        self.accountModel=[coder decodeObjectForKey:@"accountModel"];
    }
    return self;
}


- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.token forKey:@"token"];
    [coder encodeObject:self.user_id forKey:@"user_id"];
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.uinfo forKey:@"uinfo"];
    [coder encodeObject:self.homeModel forKey:@"homeModel"];
    [coder encodeObject:self.accountModel forKey:@"accountModel"];
}

@end
