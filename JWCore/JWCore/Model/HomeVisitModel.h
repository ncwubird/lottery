//
//  HomeVisitModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2017/4/26.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomeVisitItem;
@interface HomeVisitModel : NSObject

@property (nonatomic,copy) NSArray<HomeVisitItem *> *items;
@property (nonatomic,copy) NSString *page;
@property (nonatomic,copy) NSString *page_count;

@end

@interface HomeVisitItem : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) NSInteger  projectId;
@property (nonatomic,copy) NSString * age;
@property (nonatomic,copy) NSString * gestationalweeks;
@property (nonatomic,copy) NSString * nextfollowupdate;
@property (nonatomic,copy) NSString * documentID;
@property (nonatomic,copy) NSString * phone;
@property (nonatomic,copy) NSString * Lastmenstrualperiod;
@property (nonatomic,copy) NSString *remind_time;
@property (nonatomic,copy) NSString * ServiceID;
@property (nonatomic,copy) NSString * isdangerous;
@property (nonatomic,copy) NSString * is_remind;

@end
