//
//  MessageSystemModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/20.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MessageSystemModel.h"

@implementation MessageSystemModel

+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [SystemItem class]};
}


@end

@implementation SystemItem

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"desc" : @"description"};
}
@end
