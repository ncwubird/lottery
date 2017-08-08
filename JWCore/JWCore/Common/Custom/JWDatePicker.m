//
//  JWDatePicker.m
//  gloryShip
//
//  Created by WangWenjie on 15/1/9.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import "JWDatePicker.h"

@implementation JWDatePicker
JWDatePicker * datePicker;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (JWDatePicker *)shareInstance{
    if (!datePicker) {
        datePicker=[[JWDatePicker alloc] init];
        [datePicker setFrame:CGRectMake(0,KSCREEN_HEIGHT, KSCREEN_WIDTH, 216)];
        [datePicker setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
        datePicker.ishourMimute=NO;
        [datePicker createDatePickerView];
    }
    return datePicker;
}

+ (JWDatePicker *)shareInstance:(UIViewController *)ctrl hourMinute:(BOOL)hourMinute block:(JWDatePickerBlock)block{
    if (!datePicker) {
        datePicker=[[JWDatePicker alloc] init];
        [datePicker setFrame:CGRectMake(0,KSCREEN_HEIGHT, KSCREEN_WIDTH, 216)];
        [datePicker setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
        datePicker.ishourMimute=hourMinute;
        [datePicker createDatePickerView];
        //
        
    }
     [ctrl.view endEditing:YES];
    [ctrl.view addSubview:datePicker];
    [UIView animateWithDuration:0.25 animations:^{
        [datePicker setFrame:CGRectMake(0, KSCREEN_HEIGHT-datePicker.frame.size.height-50, KSCREEN_WIDTH, datePicker.frame.size.height)];
    }];
    datePicker.ctrl=ctrl;
    datePicker.datePickerBlock=block;
    datePicker.ishourMimute=hourMinute;
    [datePicker.datePickerView setDatePickerMode:UIDatePickerModeTime];
    return datePicker;
}

+ (JWDatePicker *)shareInstance:(UIViewController *)ctrl block:(JWDatePickerBlock)block{
    if (!datePicker) {
        datePicker=[[JWDatePicker alloc] init];
        [datePicker setFrame:CGRectMake(0,KSCREEN_HEIGHT, KSCREEN_WIDTH, 216)];
        [datePicker setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
        [datePicker createDatePickerView];
        //
        
    }
 [ctrl.view endEditing:YES];
    [ctrl.view addSubview:datePicker];
    [UIView animateWithDuration:0.25 animations:^{
        [datePicker setFrame:CGRectMake(0, KSCREEN_HEIGHT-datePicker.frame.size.height-50, KSCREEN_WIDTH, datePicker.frame.size.height)];
    }];
    datePicker.ctrl=ctrl;
    datePicker.datePickerBlock=block;
    datePicker.ishourMimute=NO;
    [datePicker.datePickerView setDatePickerMode:UIDatePickerModeDate];

    return datePicker;
}

-(void)createDatePickerView{
    UIView * btnBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 36)];
    [btnBackView setBackgroundColor:[UIColor colorWithRed:248.0/255.0 green:84.0/255.0 blue:57.0/255.0 alpha:1.0]];
    [self addSubview:btnBackView];
    
    UIButton * cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 0, 60, 36)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTag:1000];
    [cancelBtn addTarget:self action:@selector(datePickerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBackView addSubview:cancelBtn];
    
    UIButton * sureBtn=[[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH-60-10, 0, 60, 36)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [sureBtn setTag:1001];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(datePickerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBackView addSubview:sureBtn];
    
    self.datePickerView=[[UIDatePicker alloc] initWithFrame:CGRectMake(0,36, KSCREEN_WIDTH, 180)];
    [self.datePickerView setDatePickerMode:self.ishourMimute ? UIDatePickerModeTime : UIDatePickerModeDate];
    [self.datePickerView setBackgroundColor:[UIColor clearColor]];
    self.datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.datePickerView setUserInteractionEnabled:YES];
    [self addSubview:self.datePickerView];
}

-(void)datePickerBtnClick:(UIButton *)sender{
    if (sender.tag==1001){
        self.datePickerBlock(self.ctrl,[self.datePickerView date]);
    }
    
    [UIView animateWithDuration:.25 animations:^{
        [self setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 216)];
    }];
}

@end
