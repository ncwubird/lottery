//
//  HomeHeadView.h
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeHeadViewDelegate <NSObject>

- (void)refreshHeadViewHeightWithHeight:(CGFloat)height;

@end



@interface HomeHeadView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collect;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *freeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) NSArray *dataArray;
@property (nonatomic,copy) NSArray *unhiddenArray;

@property (nonatomic,copy) NSArray *hiddenArray;
@property (nonatomic,weak) id<HomeHeadViewDelegate>delegate;

- (void)setConfig
;
@end
