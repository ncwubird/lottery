//
//  JWDatePicker.h
//  gloryShip
//
//  Created by WangWenjie on 15/1/9.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JWDatePickerBlock) (UIViewController * ctrl,NSDate * date);

@interface JWDatePicker : UIView

@property (strong,nonatomic) UIViewController * ctrl;
@property (nonatomic,strong) JWDatePickerBlock datePickerBlock;
@property (nonatomic,strong) UIDatePicker * datePickerView;
@property (nonatomic,assign) BOOL ishourMimute;

+ (JWDatePicker *)shareInstance;

+ (JWDatePicker *)shareInstance:(UIViewController *)ctrl block:(JWDatePickerBlock)block;

+ (JWDatePicker *)shareInstance:(UIViewController *)ctrl hourMinute:(BOOL)hourMinute block:(JWDatePickerBlock)block;

@end
