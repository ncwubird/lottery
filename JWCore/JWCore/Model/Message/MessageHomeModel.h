//
//  MessageHomeModel.h
//  JWCore
//
//  Created by JayWong on 2016/9/23.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageItem;
@interface MessageHomeModel : NSObject

@property (nonatomic, copy)NSArray<MessageItem *> *items;
@end

@interface MessageItem : NSObject

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *em_name;


@end
