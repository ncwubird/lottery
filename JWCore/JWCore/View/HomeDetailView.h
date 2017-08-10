//
//  HomeDetailView.h
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/10.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JWItemsView;
@interface HomeDetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
@property (weak, nonatomic) IBOutlet UILabel *typeTitleLabel;

@property (weak, nonatomic) IBOutlet JWItemsView *itemView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemHeightConstraint;
@property (nonatomic,retain) NSMutableArray *unhiddenArray;

- (void)setSubView;

@end
