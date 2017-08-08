//
//  JWTableView.h
//  ProgramDemo
//
//  Created by WangWenjie on 15/8/12.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshManager.h"

#define PAGE_ONE 1

@interface JWTableView : UITableView


@property (nonatomic, retain, readwrite) NSMutableArray * dataArray;
@property (nonatomic, assign) NSInteger CURRENT_PAGE;
@property (nonatomic, assign) NSInteger TOTAL_PAGE;
@property (nonatomic, assign) NSInteger SIZE_PAGE;
@property (nonatomic, assign) BOOL loadInfo;

-(void)hiddenRefreshingFooterOrNot:(NSString *)current   totalPage:(NSString *)total;

-(void)resetTableData:(NSArray *)array;

-(void)endRefreshing;

@end
