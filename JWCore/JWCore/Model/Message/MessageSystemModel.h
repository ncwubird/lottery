//
//  MessageSystemModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/20.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SystemItem;
@interface MessageSystemModel : NSObject

@property (nonatomic, copy)NSArray<SystemItem *> *items;
@end

@interface SystemItem : NSObject

@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *is_read;



@end
