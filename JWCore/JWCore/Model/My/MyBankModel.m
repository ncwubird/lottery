
//
//  MyBankModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/11.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyBankModel.h"

@implementation MyBankModel

+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [BankItems class]};
}
@end

@implementation BankItems

@end
