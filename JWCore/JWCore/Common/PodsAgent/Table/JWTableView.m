//
//  JWTableView.m
//  ProgramDemo
//
//  Created by WangWenjie on 15/8/12.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import "JWTableView.h"
#import <MJRefresh.h>

@implementation JWTableView
@synthesize dataArray,CURRENT_PAGE,TOTAL_PAGE;

-(instancetype)init{
    self=[super initWithFrame:CGRectZero];

    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
            [self initProperty];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    [self initProperty];
    return self;
}

-(void)initProperty{
    self.dataArray=[NSMutableArray array];
    self.CURRENT_PAGE=1;
    self.TOTAL_PAGE=1;
    self.SIZE_PAGE=20;
}

/** 
 *判断是否隐藏table.footer
 */

-(void)hiddenRefreshingFooterOrNot:(NSString *)current   totalPage:(NSString *)total{
    if ([total integerValue]<=[current integerValue]) {
        [self.mj_footer setHidden:YES];
    }else{
        [self.mj_footer setHidden:NO];
    }
}

/** 
 *重置table数据源
 */

-(void)resetTableData:(NSArray *)array{
    
    if (self.CURRENT_PAGE==PAGE_ONE) {
        self.dataArray=[NSMutableArray array];
    }
    
    [self.dataArray addObjectsFromArray:array];
    
}

/** 
 * 停止table.header和table.footer刷新
 */

-(void)endRefreshing{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}


@end
