
//
//  MyPersonalInformationViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/26.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyPersonalInformationViewController.h"
#import "JWImagePicker.h"
#import "JWSummitFile.h"
#import "MyViewModel.h"
#import "UserLogonModel.h"
#import "MyHomeModel.h"
#import "MyDepartmentModel.h"
#import "JWPickerView.h"
#import "JWDatePicker.h"

@interface MyPersonalInformationViewController ()<JWHTTPRequestDelegate,MJRefreshManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *AuthenticationLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollv;

@property (nonatomic,retain) NSMutableDictionary * departmentDict;
@property (nonatomic,retain) NSMutableArray * departmentArray;
@property (nonatomic,retain) NSMutableArray * jobTitleArray;
@property (nonatomic,retain) NSMutableDictionary * imageDic;
@property (nonatomic,retain) UIImage *headImage;
@property (weak, nonatomic) IBOutlet UITextField *hospitalTextField;
@property (nonatomic,retain)UITextField *currenTextField;
@property (nonatomic,retain)UIView *coverView;
@end

@implementation MyPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"个人信息" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
    [self setReturnKeyTypeAndDelegateForTextfield:self.nameTextField];
    [self setReturnKeyTypeAndDelegateForTextfield:self.hospitalTextField];
    self.imageDic=[NSMutableDictionary dictionary];
    [[MJRefreshManager shareInstace] setDelegate:self];
    [MJRefreshManager addRefreshingHeader:self.scrollv];
    [self.scrollv.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   
}

#pragma mark - set user info
-(void)setUserInfo
{
    MyHomeModel *homeModel = [[[SysParams sharedInstance] logonModel] homeModel];

   [self.headImageView sd_setImageWithURL:[NSURL URLWithString:homeModel.avatar] placeholderImage:[UIImage imageNamed:@"my_headimage"]];
    self.headImageView.layer.cornerRadius = 17.5;
    self.headImageView.layer.masksToBounds = YES;

    
    self.nameTextField.text = homeModel.realname;
    self.addressLabel.text =homeModel.address;
    self.addressLabel.textAlignment = KSCREEN_WIDTH -90-[self caculateTextWidth:homeModel.address] >0?NSTextAlignmentRight:NSTextAlignmentLeft;

    self.hospitalTextField.text =homeModel.hospital_name;
    self.departmentLabel.text =homeModel.department_type;
    
    self.jobTitleLabel.text =homeModel.jobtitle;
    self.AuthenticationLabel.text = [[[[SysParams sharedInstance] logonModel] homeModel] verify_text];
    self.skillLabel.text = [homeModel.tags componentsJoinedByString:@","];
    self.skillLabel.textAlignment = KSCREEN_WIDTH -90-[self caculateTextWidth:self.skillLabel.text] >0?NSTextAlignmentRight:NSTextAlignmentLeft;
    self.liceneseTimeLabel.text =[[[[SysParams sharedInstance] logonModel] homeModel] practitioners_date];
    self.personalIntroduceLabel.text = homeModel.summary;
    self.personalIntroduceLabel.textAlignment = KSCREEN_WIDTH -90-[self caculateTextWidth:self.personalIntroduceLabel.text] >0?NSTextAlignmentRight:NSTextAlignmentLeft;
    [self verifyJudge];
}

#pragma mark - coverView
-(void)verifyJudge
{
    if([[[[[SysParams sharedInstance]logonModel]homeModel]is_verify]isEqualToString:@"Y"])
    {
        [self.scrollv bringSubviewToFront:self.coverView];
    }
    else
    {
        if(self.coverView)
        {
            [self.coverView removeFromSuperview];
        }
    }
}

-(UIView *)coverView
{   if(!_coverView)
     {
         _coverView = [[UIView alloc]initWithFrame:self.scrollv.bounds];
         _coverView.backgroundColor = [UIColor clearColor];
        [self.scrollv addSubview:_coverView];
    }
    return _coverView;
}

#pragma mark - xib action
- (IBAction)authentication:(id)sender {
    [self push:@"MyAuthenticationViewController" isNib:YES];

}

- (IBAction)headImageBtnAction:(id)sender {
   
    [JWImagePicker shareInstance:self title:@"选择头像" block:^(UIViewController *ctrl, UIImage *image) {
        self.headImage =image;
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        
        [self.imageDic setObject:[NSData dataWithContentsOfFile:fullPath] forKeyedSubscript:@"file"];
        [self summitRequest];
    }];
}

- (IBAction)addressChoose:(id)sender {
    [self push:@"MyAddressViewController" isNib:YES];
    
}

- (IBAction)administrative:(id)sender {
    if (self.departmentArray.count==0) {
        [self getDepartmentRequest:KHOME_MEMBERE_GETDEPARTMENT sender:sender];
    }
    else
    {
        [self departmentPickView:sender];
    }
}

- (IBAction)jobTitle:(id)sender {
    if (self.jobTitleArray.count==0) {
        [self getDepartmentRequest:KHOME_MEMBERE_GETJOBTITLE sender:sender];
    }
    else
    {
        [self departmentPickView:sender];
    }

}

- (IBAction)chooseLicenesTime:(id)sender {
    [JWDatePicker shareInstance:self block:^(UIViewController *ctrl, NSDate *date) {
        [self.liceneseTimeLabel setText:[NSString dateToStringYMD:date]];
        [self updateDepartmentRequestLabel:self.liceneseTimeLabel element:@"practitioners_date" button:sender];
        }];
}

- (IBAction)skilled:(id)sender {
     [self push:@"MySkillViewController" isNib:YES];
}

- (IBAction)personalIntroduce:(id)sender {
    [self push:@"MyInductionViewController" isNib:YES];
}

#pragma mark - FSHTTPRequest
-(void)summitRequest
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:[SysParams getToken] forKey:@"token"];
    [params setObject:[SysParams getUserID] forKey:@"user_id"];
    [params setObject:@"device" forKey:@"ios"];
    [params setObject:[SysFunctions appVersion] forKey:@"version"];
    [[JWSummitFile shareInstance] setDelegate:self];
    [[JWSummitFile shareInstance] postRequestWithParems:[NSString stringWithFormat:@"%@%@",[SysFunctions getBaseURL],KHOME_IMAGE_UPLOAD] postParams:params files:([[self.imageDic allKeys] count]==0 ? nil : self.imageDic)];
 
}

#pragma mark - FSHTTPRequestDelegate
-(void)httpRequestResult:(NSDictionary *)result{
    NSLog(@"%@",result);

    ViewModel * viewModel=[ViewModel new];
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:result];
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([viewModel isCorrectResponse:responseModel]) {
        
        MyViewModel *viewModel =[MyViewModel new];
        [viewModel setBlockWithReturnBlock:^(id returnValue) {
            if ([returnValue isKindOfClass:[SPResponseModel class]]) {
                [JWProgressView showSuccessWithStatus:@"上传成功"];
                self.headImageView.image =self.headImage;
                self.headImageView.layer.cornerRadius = 17.5;
                self.headImageView.layer.masksToBounds = YES;
                [[[[SysParams sharedInstance] logonModel] homeModel] setAvatar:responseModel.url];
                [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
                NSLog(@"%@",[[[[SysParams sharedInstance] logonModel] homeModel]avatar]);
            }
        } WithFailureBlock:^{
        }];
        NSDictionary *params = [viewModel headPortraitsUpdateRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion] avatar:responseModel.url];
        [viewModel headPortraitsUpdateTaskWithParams:params];
}
}

#pragma mark - textField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.currenTextField =textField;
    if (![self.nameTextField isEmptyValue]&&textField ==self.nameTextField) {
        [self updateInfoRequest:self.nameTextField.text parameter:@"realname"];
    }
    else if (![self.hospitalTextField isEmptyValue]&&textField ==self.hospitalTextField)
    {
        [self updateInfoRequest:self.hospitalTextField.text parameter:@"hospital_name"];
    }
}

#pragma mark - get doctorinfo request
-(void)getDoctorInfoHttpRequest
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[MyHomeModel class]]) {
            [self.scrollv.mj_header endRefreshing];
            [[[SysParams sharedInstance] logonModel] setHomeModel:(MyHomeModel *)returnValue];
            [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
            [self setUserInfo];
        }
    } WithFailureBlock:^{
        [self.scrollv.mj_header endRefreshing];
        [self.scrollv bringSubviewToFront:self.coverView];

    }];
    
    NSMutableDictionary *params = [viewModel getAccountInfoRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion] ];
    
    [viewModel getUserInfoTaskWithParams:params];
}

#pragma mark - update name and hospital request
-(void)updateInfoRequest:(NSString *)text parameter:(NSString *)parameter
{
     MyViewModel *viewModel =[MyViewModel new];
     [viewModel setBlockWithReturnBlock:^(id returnValue) {
       if ([returnValue isKindOfClass:[SPResponseModel class]]) {
           if (self.currenTextField ==self.nameTextField) {
               [[[[SysParams sharedInstance] logonModel] homeModel] setRealname:self.nameTextField.text];
           }
           else
           {
                [[[[SysParams sharedInstance] logonModel] homeModel] setHospital_name:self.hospitalTextField.text];
           }
           
           [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
           [JWProgressView showSuccessWithStatus:[(SPResponseModel *)returnValue msg]];
              }
     } WithFailureBlock:^{
         self.currenTextField.text =nil;
      }];

    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:[SysParams getUserID] forKey:@"user_id"];
    [params setObject:[SysParams getToken] forKey:@"token"];
    [params setObject:@"iOS"forKey:@"device"];
    [params setObject:[SysFunctions appVersion] forKey:@"version"];
    [params setObject:text forKey:parameter];
    [viewModel updateUserInfoTaskWithParams:params];
}

#pragma mark - update department and jobtitle request
-(void)updateDepartmentRequestLabel:(UILabel *)label element:(NSString *)element button:(UIButton *)sender
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            if (sender.tag==100) {
                [[[[SysParams sharedInstance] logonModel] homeModel] setDepartment_type:label.text];
             }
            else if (sender.tag==101)
            {
                [[[[SysParams sharedInstance] logonModel] homeModel] setJobtitle:label.text];
            }
            else
            {
                [[[[SysParams sharedInstance] logonModel] homeModel] setPractitioners_date:label.text];
            }

            [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
            [JWProgressView showSuccessWithStatus:[(SPResponseModel *)returnValue msg]];
        }
    } WithFailureBlock:^{
        label.text =nil;
    }];
    
    NSMutableDictionary *params = [viewModel updateUserInfoRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]];
    if (sender.tag==100) {
         [params setObject:[self.departmentDict objectForKey:label.text] forKey:element];
    }
    else
    {
        [params setObject:label.text forKey:element];
    }

    [viewModel updateUserInfoTaskWithParams:params];
}

-(void)getDepartmentRequest:(NSString *)url sender:(UIButton *)sender
{
    MyViewModel *viewModel =[MyViewModel new];
    NSMutableArray *textArr = [NSMutableArray array];
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[MyDepartmentModel class]]) {

        for (MyItems *items in [(MyDepartmentModel *)returnValue items] ) {
            [textArr addObject:items.text];
            [textDict setObject:items.code forKey:items.text];
        }
    
        switch (sender.tag) {
            case 100:
            {
            self.departmentDict = [NSMutableDictionary dictionaryWithDictionary:textDict];
            self.departmentArray = [NSMutableArray arrayWithArray:textArr];
             [self departmentPickView:sender];
            }
                break;
   
            case 101:
            {
             self.jobTitleArray = [NSMutableArray arrayWithArray:textArr];
             [self departmentPickView:sender];
            }
                break;
            default:
                break;
          }
     }
    } WithFailureBlock:^{
    }];
    
    NSMutableDictionary *params = [viewModel updateUserInfoRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]];
    [viewModel getDepartmentListTaskWithUrl:url Params:params];
}

-(void)departmentPickView:(UIButton *)sender
{
    NSMutableArray *dataArr = sender.tag==100?self.departmentArray:self.jobTitleArray;
    [JWPickerView shareInstance:dataArr  ctrl:self selectRow:0 block:^(UIViewController *ctrl, NSString *str) {
        if (sender.tag ==100) {
            self.departmentLabel.text = str;
            [self updateDepartmentRequestLabel:self.departmentLabel element:@"department_type" button:sender];
        }
        else
        {
            self.jobTitleLabel.text =str;
            [self updateDepartmentRequestLabel:self.jobTitleLabel element:@"jobtitle" button:sender];      }
       
    }];

}
-(CGFloat)caculateTextWidth:(NSString *)text
{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    return size.width;
}

#pragma mark - mjfreshdelegate
-(void)loadNewData
{
    [self getDoctorInfoHttpRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
