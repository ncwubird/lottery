//
//  MyTagsModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/12.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyTagsModel.h"

@implementation MyTagsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"items" : [TagsItems class]};
}

@end

@implementation TagsItems

@end
