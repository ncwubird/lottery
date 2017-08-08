//
//  JWAddressPickView.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/11.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "JWAddressPickView.h"
#import "NSObject+MJKeyValue.h"
#import "MyAddressModel.h"

@implementation JWAddressPickView
JWAddressPickView *addressPickView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self jsonAnalysis];
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

+ (JWAddressPickView *)shareInstance:(UIViewController *)ctrl block:(StrValueBlock)block
{
    static dispatch_once_t   p;
    dispatch_once(&p,^{
        addressPickView=[[JWAddressPickView alloc] init];
        [addressPickView setFrame:CGRectMake(0,KSCREEN_HEIGHT, KSCREEN_WIDTH, 252)];
        [addressPickView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
        [addressPickView setUserInteractionEnabled:YES];
        [addressPickView createPickerView];
    });
    //
    [ctrl.view endEditing:YES];
    [ctrl.view addSubview:addressPickView];
    [UIView animateWithDuration:0.25 animations:^{
        [addressPickView setFrame:CGRectMake(0, KSCREEN_HEIGHT-addressPickView.frame.size.height-50, KSCREEN_WIDTH, addressPickView.frame.size.height)];
    }];
    //
    addressPickView.valueBlock=block;
    addressPickView.ctrl=ctrl;
    [addressPickView.pickerView reloadAllComponents];
    [addressPickView.pickerView selectRow:0 inComponent:0 animated:NO];
    [addressPickView.pickerView selectRow:0 inComponent:1 animated:NO];
    [addressPickView.pickerView selectRow:0 inComponent:2 animated:NO];

    return addressPickView;
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
    
    self.pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0,36, KSCREEN_WIDTH, 234)];
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
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return self.dataArr.count;
    }
    else if (component ==1)
    {
        
    return [[self.dataArr[self.provinceIndex] city] count];
    }
    else if (component ==2)
    {
        City *city = [[self.dataArr[self.provinceIndex] city] objectAtIndex:self.cityIndex];
        return city.area.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        MyAddressModel *model =self.dataArr[row];
        return model.name;
    }
    else if (component ==1)
    {
        City *city = [[self.dataArr[self.provinceIndex] city] objectAtIndex:row];
        return city.name;
     
    }
    else if (component==2)
    {
        City *city = [[self.dataArr[self.provinceIndex] city] objectAtIndex:self.cityIndex];
         Area *area = city.area[row];
        return area.name;
     }
    return nil;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        
        self.provinceIndex = [thePickerView selectedRowInComponent:0];
        [thePickerView reloadComponent:1];
        self.cityIndex=0;
        [thePickerView selectRow:0 inComponent:1 animated:NO];
        [thePickerView reloadComponent:2];
        [thePickerView selectRow:0 inComponent:2 animated:NO];
      
    }
    else if (component==1)
    {
        self.cityIndex = [thePickerView selectedRowInComponent:1];
        [thePickerView reloadComponent:2];
         
        [thePickerView selectRow:0 inComponent:2 animated:NO];
        self.countyIndex=0;
     }
    else
    {
        self.countyIndex =[thePickerView selectedRowInComponent:2];
     }
    /*if (self.countyIndex>=[[self.dataArr[self.provinceIndex] city] count] )
    {
        [thePickerView selectRow:0 inComponent:2 animated:YES];
    }*/
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)pickerBtnClick:(UIButton *)sender{
    if (sender.tag==1001){
        if ([self.dataArr count]!=0) {
            int leftRow = [self.pickerView selectedRowInComponent:0];
            int middleRow = [self.pickerView selectedRowInComponent:1];
            int rightRow = [self.pickerView selectedRowInComponent:2];
            MyAddressModel *model =self.dataArr[leftRow];
            City *city = [[self.dataArr[leftRow] city] objectAtIndex:middleRow];
            Area *area = city.area[rightRow];
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:model.name,city.name,area.name, nil];
            self.valueBlock(self.ctrl,arr);
        }
    }
    [UIView animateWithDuration:.25 animations:^{
        [self setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 252)];
    }];
}

#pragma mark -json data
-(void)jsonAnalysis
{
    self.dataArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMapped error:nil];
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    for (int i =0;  i<jsonArray.count;i++) {
        MyAddressModel *model = [MyAddressModel mj_objectWithKeyValues:[jsonArray objectAtIndex:i]];
        [self.dataArr addObject:model];
    }
}

@end
