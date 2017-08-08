//
//  VTSelectionPickerView.h
//  huiyang
//
//  Created by Mac on 14-2-21.
//  Copyright (c) 2014年 wwj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^passStrValueBlock) (UIViewController * ctrl,NSString *str);

@interface JWPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong,nonatomic) NSArray * dataArr;
@property (strong,nonatomic) NSString * readKey;
@property (strong,nonatomic) UIPickerView * pickerView;
@property (strong,nonatomic) passStrValueBlock  valueBlock;
@property (strong,nonatomic) UIViewController * ctrl;

+ (JWPickerView *)shareInstance:(NSArray *)arr  ctrl:(UIViewController *)ctrl  selectRow:(NSInteger)row block:(passStrValueBlock)block;

@end
