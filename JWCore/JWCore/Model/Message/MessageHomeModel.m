//
//  MessageHomeModel.m
//  JWCore
//
//  Created by JayWong on 2016/9/23.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MessageHomeModel.h"

@implementation MessageHomeModel

+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [MessageItem class]};
}

@end

@implementation MessageItem

@end
