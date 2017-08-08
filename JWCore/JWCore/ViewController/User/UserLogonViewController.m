//
//  UserLogonViewController.m
//  JWCore
//
//  Created by JayWong on 16/9/9.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "UserLogonViewController.h"
#import "SCUserProfileEntity.h"
#import "UserViewModel.h"
#import "UserLogonModel.h"
#import "EMError.h"

//#import "ChatDemoHelper.h"

@interface UserLogonViewController ()

@end

@implementation UserLogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    [self setDelegateAndNumberKeyboardForTextfield:self.accountTextField type:UIKeyboardTypeNumberPad];
    [self setReturnKeyTypeAndDelegateForTextfield:self.passwordTextField];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self addNavBar:@"nav_clear" leftBtn:BAR_BTN_NONE rightBtn:BAR_BTN_NONE];
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

#pragma mark -events response

- (IBAction)logonAction:(id)sender {
    
    if (![self checkValue]) return;
    [self logonRequest];
}

- (IBAction)registerAction:(id)sender {
   [self push:@"UserRegisterViewController" isNib:YES];
}

- (IBAction)forgetPasswordAction:(id)sender {
    [self push:@"UserForgetPasswordViewController" isNib:YES];
}

#pragma mark -request

-(void)logonRequest{
    UserViewModel * viewModel=[UserViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[UserLogonModel class]]) {
            UserLogonModel *loginModel = returnValue;
            MyHomeModel *homeModel = [MyHomeModel  mj_objectWithKeyValues:loginModel.uinfo];
            loginModel.homeModel =homeModel;
            [SysParams saveLogonModel:loginModel];
            

            [JWProgressView showSuccessWithStatus:@"登录成功!"];
            
           [self performSelector:@selector(didLogon) withObject:nil afterDelay:1.5];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
                if (!isAutoLogin) {
                    NSString *name = [[[[SysParams sharedInstance]logonModel] homeModel] em_name] ;
                    NSString *pwd = [[[[SysParams sharedInstance]logonModel] homeModel] em_pwd] ;
                    EMError *loginError = [[EMClient sharedClient] loginWithUsername:name password:pwd];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!loginError) {
                            NSLog(@"登陆成功");
                    [[EMClient sharedClient].options setIsAutoLogin:YES];}
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //[[EMClient sharedClient].chatManager loadAllConversationsFromDB];
                [[EMClient sharedClient] migrateDatabaseToLatestSDK];
                dispatch_async(dispatch_get_main_queue(), ^{
//                [[ChatDemoHelper shareHelper] asyncGroupFromServer];
//                [[ChatDemoHelper shareHelper] asyncConversationFromDB];
//                [[ChatDemoHelper shareHelper] asyncPushOptions];
                
//                    //发送自动登陆状态通知
//                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];
                    
                    //保存最近一次登录用户名
                   // [weakself saveLastLoginUsername];
                                });

                 });});}
                });
        }
    } WithFailureBlock:^{
        
    }];
    NSDictionary * params=[viewModel logonRequestURLWithAccount:self.accountTextField.text type:@"doctor" password:self.passwordTextField.text device:@"iOS" version:[SysFunctions appVersion]];
    [viewModel logonTaskWithParams:params];
}

#pragma mark -private

-(BOOL)checkValue{
    if ([self.accountTextField isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请输入手机号码!"];
        return NO;
    }
    
    if (![JWRegex regexCellphoneNo:self.accountTextField.text]) {
        [JWProgressView showErrorWithStatus:@"请输入正确手机号码!"];
        return NO;
    }
    
    if ([self.passwordTextField isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请输入密码!"];
        return NO;
    }
    
    return YES;
}

-(void)didLogon{
    if ( [[NSUserDefaults standardUserDefaults]objectForKey:@"logout"])
    {
         [[NSNotificationCenter defaultCenter] postNotificationName:KUSER_LOGIN_OUT object:nil];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"logout" forKey:@"logout"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:KUSER_RELOAD_MESSAGE object:nil];
    [self.navigationController dismissModalViewController];
}

@end
