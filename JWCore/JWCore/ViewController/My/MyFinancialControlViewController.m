//
//  MyFinancialControlViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/26.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyFinancialControlViewController.h"
#import "MyIdentificationAlertView.h"
#import "MyAccountInfoModel.h"
#import "MyViewModel.h"
#import "MyAccountInfoModel.h"
#import "MySetBankCardViewController.h"
@interface MyFinancialControlViewController ()<MJRefreshManagerDelegate,BankDelegate>
@property (nonatomic,retain)MyIdentificationAlertView *myAlertView;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankIdLabel;

@property (weak, nonatomic) IBOutlet UIButton *bankIdBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollv;


@end

@implementation MyFinancialControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"财务管理" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
    [[MJRefreshManager shareInstace] setDelegate:self];
    [MJRefreshManager addRefreshingHeader:self.scrollv];
    
//   if ( [[[[[SysParams sharedInstance] logonModel]homeModel] is_verify]isEqualToString:@"Y"]) {
        [self.scrollv.mj_header beginRefreshing];
//       }
//    else
//    {
//        [self.view bringSubviewToFront:self.myAlertView];
//    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   
    
}

-(MyIdentificationAlertView *)myAlertView
{
    if (_myAlertView == nil) {
        _myAlertView = [[MyIdentificationAlertView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        [_myAlertView.leftBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
        [_myAlertView.rightBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
        [[SysFunctions keyWindow] addSubview:_myAlertView];
    }
    return _myAlertView;
}

-(void)alertClick:(UIButton *)sender
{
    [self.myAlertView removeFromSuperview];
    if (sender==_myAlertView.leftBtn)
    {
      [self push:@"MyAuthenticationViewController" isNib:YES];
    }
  else
    {
        [self pop:YES];
    }
}

-(void)setAccountInfo
{
    NSString *verify = [[[[SysParams sharedInstance] logonModel] homeModel] is_verify];
    if ([verify isEqualToString:@"Y"]) {
        MyAccountInfoModel *model = [[[SysParams sharedInstance] logonModel]accountModel];
        
        NSString *bankString =[model.bankcard objectForKey:@"bankNo"];
        if ([NSString isEmptyString:bankString]) {
            [self.bankIdBtn setTitle:@"设置" forState:UIControlStateNormal];
            self.bankIdLabel.text = @"未设置收款账号";
           
        }
        else
        {
            [self.bankIdBtn setTitle:@"更改" forState:UIControlStateNormal];
            
            self.bankIdLabel.text = model.bankcard[@"bankNo"];
        }
        self.totalMoneyLabel.text =model.money;
        self.balanceMoneyLabel.text =model.balance;
        self.collectionMoneyLabel.text = model.pay_money;
     }
    else
    {
         [self myAlertView];
    }
}

#pragma mark - xib Action
- (IBAction)moneyRecoder:(id)sender {
    [self push:@"MyAccountDetailViewController" isNib:YES];
}
- (IBAction)changeBankCard:(id)sender {
    MySetBankCardViewController *vc = [[MySetBankCardViewController alloc]init];
    vc.delegate =self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -account info request
-(void)getAccountInfoHttpRequest
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[MyAccountInfoModel class]]) {
            [self.scrollv.mj_header endRefreshing];
            MyAccountInfoModel *model =(MyAccountInfoModel *)returnValue;
            
            [self setAccountInfo];
            [[[SysParams sharedInstance] logonModel] setAccountModel:model];
            [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
           
        }
    } WithFailureBlock:^{
         [self.scrollv.mj_header endRefreshing];
    }];
    
    NSMutableDictionary *params = [viewModel getAccountInfoRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion] ];
    
    [viewModel getAccountInfoTaskWithParams:params];
}

#pragma mark - mjfresh delegate
-(void)loadNewData
{
    [self getAccountInfoHttpRequest];
}

#pragma mark - bank delegate
-(void)reloadBankInfo
{
   [self.scrollv.mj_header beginRefreshing];
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
