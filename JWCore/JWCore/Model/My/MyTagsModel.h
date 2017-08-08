//
//  MyTagsModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/12.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TagsItems;

@interface MyTagsModel : NSObject

@property (nonatomic, copy) NSArray<TagsItems *> *items;
@property (nonatomic, copy) NSString *msg;
@end

@interface TagsItems : NSObject

@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *enabled;


@end
