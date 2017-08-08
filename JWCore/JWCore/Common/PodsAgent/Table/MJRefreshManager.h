//
//  MJRefreshManager.h
//  ProgramDemo
//
//  Created by WangWenjie on 15/8/10.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"
#import "MJCustomGifHeader.h"
#import "MJCustomGifFooter.h"

@protocol MJRefreshManagerDelegate

@optional

-(void)loadNewData;

-(void)loadMoreData;

@end

typedef NS_ENUM(NSInteger, RefreshingType) {
    RefreshingTypeCustomText = 0,
    RefreshingTypeGIF=1
};

@interface MJRefreshManager : NSObject

@property (assign,nonatomic) RefreshingType refreshingType;
@property (retain,nonatomic) id<MJRefreshManagerDelegate> delegate;


+(MJRefreshManager *)shareInstace;

+(void)addRefreshingHeaderAndRefreshingFooter:(UITableView *)table;

+(void)addRefreshingHeaderAndFooter:(UITableView *)table;

+(void)addRefreshingHeader:(UIScrollView *)scroll;

@end
