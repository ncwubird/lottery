//
//  MyAccountRecoderModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/14.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyAccountRecoderModel.h"
@implementation MyAccountRecoderModel

+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [RecoderItem class]};
}


@end

@implementation RecoderItem

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"desc" : @"description"};
}
@end
