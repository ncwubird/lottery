//
//  MyAddressModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/11.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyAddressModel.h"

@implementation MyAddressModel
+ (NSDictionary *)objectClassInArray{
    return @{@"city" : [City class]};
}

@end

@implementation City
+ (NSDictionary *)objectClassInArray{
    return @{@"area" : [Area class]};
}


@end

@implementation Area

@end
