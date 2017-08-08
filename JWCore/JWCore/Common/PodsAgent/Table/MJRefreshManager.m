//
//  MJRefreshManager.m
//  ProgramDemo
//
//  Created by WangWenjie on 15/8/10.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#define KREFRESHING_HEADER_IDLE @"下拉可以刷新"
#define KREFRESHING_HEADER_PULLING @"松开立即刷新"
#define KREFRESHING_HEADER_REFRESHING @"正在为你刷新数据"

#define KREFRESHING_FOOTER_IDLE @"点击加载更多"
#define KREFRESHING_FOOTER_REFRESHING @"正在为你加载更多数据"
#define KREFRESHING_FOOTER_NO_DATA @"没有更多数据了!"

#import "MJRefreshManager.h"

static MJRefreshManager * refreshManager;


@implementation MJRefreshManager

+(MJRefreshManager *)shareInstace{
    if (!refreshManager) {
        refreshManager=[[self alloc] init];
        refreshManager.refreshingType=RefreshingTypeCustomText;
    }
    return refreshManager;
}

+(void)addRefreshingHeaderAndFooter:(UITableView *)table{

    [MJRefreshManager shareInstace];
    
    switch (refreshManager.refreshingType) {
        case RefreshingTypeCustomText:{
            table.mj_header=[refreshManager headerRefreshingWithCustomText];
            table.mj_footer=[refreshManager footerRefreshingWithCustomText];
            [table.mj_header beginRefreshing];
            [table.mj_footer setHidden:YES];
        }
            break;
        case RefreshingTypeGIF:{
            table.mj_header=[refreshManager headerRefreshingWithGIF];
            table.mj_footer=[refreshManager footerRefreshingWithGIF];
            [table.mj_header beginRefreshing];
            [table.mj_footer setHidden:YES];
        }
            
        default:
            break;
    }
}

+(void)addRefreshingHeaderAndRefreshingFooter:(UITableView *)table{
    
    [MJRefreshManager shareInstace];
    
    switch (refreshManager.refreshingType) {
        case RefreshingTypeCustomText:{
            table.mj_header=[refreshManager headerRefreshingWithCustomText];
            table.mj_footer=[refreshManager footerRefreshingWithCustomText];
            [table.mj_header beginRefreshing];
            
        }
            break;
        case RefreshingTypeGIF:{
            table.mj_header=[refreshManager headerRefreshingWithGIF];
            table.mj_footer=[refreshManager footerRefreshingWithGIF];
            [table.mj_header beginRefreshing];
           
        }
            
        default:
            break;
    }
}

+(void)addRefreshingHeader:(UIScrollView *)scroll{
    
    [MJRefreshManager shareInstace];
    
    switch (refreshManager.refreshingType) {
        case RefreshingTypeCustomText:{
            scroll.mj_header=[refreshManager headerRefreshingWithCustomText];
        }
            break;
        case RefreshingTypeGIF:{
            scroll.mj_header=[refreshManager headerRefreshingWithGIF];
        }
            
        default:
            break;
    }
}

//-(void)setRefreshingType:(RefreshingType )refreshingType{
//    self.refreshingType=refreshingType;
//}

#pragma mark -自定义文字-

- (MJRefreshNormalHeader *)headerRefreshingWithCustomText{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.delegate refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:KREFRESHING_HEADER_IDLE forState:MJRefreshStateIdle];
    [header setTitle:KREFRESHING_HEADER_PULLING forState:MJRefreshStatePulling];
    [header setTitle:KREFRESHING_HEADER_REFRESHING forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont boldSystemFontOfSize:16];
    header.lastUpdatedTimeLabel.hidden=YES;
    header.lastUpdatedTimeLabel.font = [UIFont boldSystemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor blackColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
    
    // 设置刷新控件
    return header;
}

- (MJRefreshAutoNormalFooter *)footerRefreshingWithCustomText{
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self.delegate refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [footer setTitle:KREFRESHING_FOOTER_IDLE forState:MJRefreshStateIdle];
    [footer setTitle:KREFRESHING_FOOTER_REFRESHING forState:MJRefreshStateRefreshing];
    [footer setTitle:KREFRESHING_FOOTER_NO_DATA forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont boldSystemFontOfSize:16];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blackColor];
    
    return footer;
}

#pragma mark -动态图片+隐藏状态和时间-

- (MJCustomGifHeader *)headerRefreshingWithGIF
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJCustomGifHeader *header = [MJCustomGifHeader headerWithRefreshingTarget:self.delegate refreshingAction:@selector(loadNewData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 返回header
    return header;
}

- (MJCustomGifFooter *)footerRefreshingWithGIF
{
    MJCustomGifFooter *footer = [MJCustomGifFooter footerWithRefreshingTarget:self.delegate refreshingAction:@selector(loadMoreData)];
    
    [footer setTitle:KREFRESHING_FOOTER_IDLE forState:MJRefreshStateIdle];
    [footer setTitle:KREFRESHING_FOOTER_REFRESHING forState:MJRefreshStateRefreshing];
    [footer setTitle:KREFRESHING_FOOTER_NO_DATA forState:MJRefreshStateNoMoreData];
    
    return footer;
}

@end
