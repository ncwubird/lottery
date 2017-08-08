//
//  JWAddressPickView.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/11.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^StrValueBlock) (UIViewController * ctrl,NSMutableArray * arr);

@interface JWAddressPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong,nonatomic) NSMutableArray * dataArr;
@property (strong,nonatomic) UIPickerView * pickerView;
@property (strong,nonatomic) StrValueBlock  valueBlock;
@property (strong,nonatomic) UIViewController * ctrl;
@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger countyIndex;



+ (JWAddressPickView *)shareInstance:(UIViewController *)ctrl block:(StrValueBlock)block;


@end
