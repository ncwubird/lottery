//
//  MyDepartmentModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/12.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyDepartmentModel.h"

@implementation MyDepartmentModel
+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [MyItems class]};
}

@end

@implementation MyItems

@end


