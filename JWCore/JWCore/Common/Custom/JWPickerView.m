//
//  VTSelectionPickerView.m
//  huiyang
//
//  Created by Mac on 14-2-21.
//  Copyright (c) 2014年 wwj. All rights reserved.
//

#import "JWPickerView.h"

@implementation JWPickerView
JWPickerView * instance;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

//-(void)setFrame:(CGRect)frame{
//    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 216)];
//}

+ (JWPickerView *)shareInstance:(NSArray *)arr  ctrl:(UIViewController *)ctrl selectRow:(NSInteger)row block:(passStrValueBlock)block
{
    static dispatch_once_t   p;
    dispatch_once(&p,^{
        instance=[[JWPickerView alloc] init];
        [instance setFrame:CGRectMake(0,KSCREEN_HEIGHT, KSCREEN_WIDTH, 216)];
        [instance setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
        [instance setUserInteractionEnabled:YES];
        [instance createPickerView];
    });
    //
    [ctrl.view endEditing:YES];
    [ctrl.view addSubview:instance];
    [UIView animateWithDuration:0.25 animations:^{
        [instance setFrame:CGRectMake(0, KSCREEN_HEIGHT-instance.frame.size.height-50, KSCREEN_WIDTH, instance.frame.size.height)];
    }];
    //
    instance.dataArr=arr;
    instance.valueBlock=block;
    instance.ctrl=ctrl;
    [instance.pickerView reloadAllComponents];
    
    [instance.pickerView selectRow:row inComponent:0 animated:NO];
    return instance;
}

-(void)createPickerView{
    UIView * btnBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 36)];
    [btnBackView setBackgroundColor:[UIColor colorWithRed:248.0/255.0 green:84.0/255.0 blue:57.0/255.0 alpha:1.0]];
    [self addSubview:btnBackView];
    
    UIButton * cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 0, 60, 36)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTag:1000];
    [cancelBtn addTarget:self action:@selector(pickerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBackView addSubview:cancelBtn];
    
    UIButton * sureBtn=[[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH-60-10, 0, 60, 36)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [sureBtn setTag:1001];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(pickerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnBackView addSubview:sureBtn];
    
    self.pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0,36, KSCREEN_WIDTH, 180)];
    self.pickerView.showsSelectionIndicator = YES;
    [self.pickerView setBackgroundColor:[UIColor clearColor]];
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    [self.pickerView setUserInteractionEnabled:YES];
    [self addSubview:self.pickerView];
    
}

#pragma  mark -UIPickViewDelegate-

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataArr count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.dataArr objectAtIndex:row] ;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{}
-(void)pickerBtnClick:(UIButton *)sender{
    if (sender.tag==1001){
        if ([self.dataArr count]!=0) {
             self.valueBlock(self.ctrl,[self.dataArr objectAtIndex:[self.pickerView selectedRowInComponent:0]]);
        }
    }
    [UIView animateWithDuration:.25 animations:^{
        [self setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 216)];
    }];
}


@end
