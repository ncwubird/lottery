
//
//  MyAccountInfoModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/13.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyAccountInfoModel.h"

@implementation MyAccountInfoModel


- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.money = [coder decodeObjectForKey:@"money"];
        self.pay_money=[coder decodeObjectForKey:@"pay_money"];
        self.balance=[coder decodeObjectForKey:@"balance"];
        self.bankcard=[coder decodeObjectForKey:@"bankcard"];
        self.disabled=[coder decodeObjectForKey:@"disabled"];
        self.disabled=[coder decodeObjectForKey:@"subscriber_identity"];

    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.money forKey:@"money"];
    [coder encodeObject:self.pay_money forKey:@"pay_money"];
    [coder encodeObject:self.balance forKey:@"balance"];
    [coder encodeObject:self.bankcard forKey:@"bankcard"];
    [coder encodeObject:self.disabled forKey:@"disabled"];
    [coder encodeObject:self.disabled forKey:@"subscriber_identity"];

}

@end

