//
//  MyHomeViewController.m
//  JWCore
//
//  Created by JayWong on 2016/9/23.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyHomeViewController.h"
#import "MyViewModel.h"
#import "MyHomeModel.h"
#import "MyAccountInfoModel.h"
#import "MyQRcodeView.h"
@interface MyHomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorHospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *AuthenticationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageview;

@end

@implementation MyHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutReload) name:KUSER_LOGIN_OUT object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{  [super viewWillAppear:YES];
   [self addNavBar:@"nav_clear" leftBtn:BAR_BTN_NONE rightBtn:BAR_BTN_QRCODE];
    [self setUserInfo];
    [self getFinnalRequest];
}

-(void)navBarAction_Qrcode:(UIButton *)sender
{
    if ([[[[[SysParams sharedInstance]logonModel]homeModel] is_verify] isEqualToString:@"Y"]) {
        MyQRcodeView *view = [[MyQRcodeView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        [[SysFunctions keyWindow]addSubview:view];
        }
}

-(void)loginOutReload
{
    [self setUserInfo];

    [self getFinnalRequest];
}

-(void)getFinnalRequest
{
    if ( [[[[[SysParams sharedInstance] logonModel]homeModel] is_verify]isEqualToString:@"Y"]) {
        [self getAccountInfoHttpRequest];
    }

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
#pragma mark -user info
-(void)setUserInfo
{   MyHomeModel *homeModel = [[[SysParams sharedInstance] logonModel] homeModel];
    
    [self.headImageview sd_setImageWithURL:[NSURL URLWithString:homeModel.avatar] placeholderImage:[UIImage imageNamed:@"my_headimage"]];
    self.headImageview.layer.cornerRadius = 27;
    self.headImageview.layer.masksToBounds = YES;

    self.userNameLabel.text = homeModel.realname;
    self.doctorHospitalLabel.text = homeModel.hospital_name;
    self.AuthenticationLabel.text = [[[[SysParams sharedInstance] logonModel] homeModel] verify_text];
}


#pragma mark -xib action

- (IBAction)CertificationBtnAction:(id)sender {
       [self push:@"MyAuthenticationViewController" isNib:YES];
}
- (IBAction)RecommendBtnAction:(id)sender {
}
- (IBAction)financialControlBtnAction:(id)sender {
    [self push:@"MyFinancialControlViewController" isNib:YES];

}
- (IBAction)settingBtnAction:(id)sender {
    [self push:@"MySettingViewController" isNib:YES];
}
- (IBAction)memberCenterBtnAction:(id)sender {
    [self push:@"MyPersonalInformationViewController" isNib:YES];

}

#pragma mark -account info request
-(void)getAccountInfoHttpRequest
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[MyAccountInfoModel class]]) {
            MyAccountInfoModel *model =(MyAccountInfoModel *)returnValue;
            self.totalMoneyLab.text =[NSString stringWithFormat:@"%@元",model.money];
           [[[SysParams sharedInstance] logonModel] setAccountModel:model];
            [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
        }
    } WithFailureBlock:^{
        
    }];
    
    NSMutableDictionary *params = [viewModel getAccountInfoRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion] ];
    
    [viewModel getAccountInfoTaskWithParams:params];
}

@end
