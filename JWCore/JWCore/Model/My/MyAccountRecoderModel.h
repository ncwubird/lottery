//
//  MyAccountRecoderModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/14.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecoderItem;
@interface MyAccountRecoderModel : NSObject

@property (nonatomic, copy)NSArray<RecoderItem *> *items;
@property (nonatomic, retain) NSString *page;
@property (nonatomic, retain) NSString *page_count;

@end

@interface RecoderItem : NSObject

@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *subscriber_identity;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *record_type;
@property (nonatomic, copy) NSString *expand_identity;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *setup_date;
@property (nonatomic, copy) NSString *disabled;



@end
