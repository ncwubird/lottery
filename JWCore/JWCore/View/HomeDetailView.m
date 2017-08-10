//
//  HomeDetailView.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/10.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "HomeDetailView.h"
#import "JWItemsView.h"

@implementation HomeDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *homeViewXib = [[NSBundle mainBundle] loadNibNamed:@"HomeDetailView" owner:self options:nil];
        self = [homeViewXib objectAtIndex:0];
        [self setFrame:frame];
        //[self setSubView];
    }
    return self;
}

- (void)setSubView
{
    CGFloat height = [JWItemsView itemsHeightWithArray:_unhiddenArray width:KSCREEN_WIDTH - 10];
    _itemHeightConstraint.constant = height;
    [_itemView addItemsWithArray:_unhiddenArray width:KSCREEN_WIDTH - 10];
    [self layoutIfNeeded];
    
}

#pragma mark -getter
- (NSMutableArray *)unhiddenArray
{
    if (!_unhiddenArray) {
        _unhiddenArray = [@[@"蓝球定三",@"红球独胆",@"蓝球定五",@"红球杀三",@"蓝球杀五",@"红球双胆",@"红球12码",@"红球杀六",@"红球三胆",@"红球25码",@"红球20码"] mutableCopy];
    }
    return _unhiddenArray;
}


@end
