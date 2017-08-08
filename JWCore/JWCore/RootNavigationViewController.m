//
//  RootNavigationViewController.m
//  JWCore
//
//  Created by JayWong on 16/9/13.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "RootNavigationViewController.h"
#import "RootTabbarViewController.h"
#import "SPLaughView.h"
//#import "SettingsViewController.h"
//#import "ApplyViewController.h"
//#import "UserProfileManager.h"
//#import "ContactListViewController.h"
//#import "ChatDemoHelper.h"
//#import "RedPacketChatViewController.h"

@interface RootNavigationViewController ()<UIAlertViewDelegate>


@end

@implementation RootNavigationViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;  //只允许执行一次（以防分享和选择图片跳转回来执行）
    dispatch_once(&onceToken, ^{
        [self startLaugh];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showReloginAlert) name:KUSER_LOGIN_INVALID object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
//    
//    [self setupUnreadMessageCount];
//    [self setupUntreatedApplyCount];
    
    //[ChatDemoHelper shareHelper].contactViewVC = _contactsVC;
    //[ChatDemoHelper shareHelper].conversationListVC = _chatListVC;

}
#pragma mark -登陆失效,重新登陆

-(void)showReloginAlert{
    if ([SysFunctions keyWindow]==[[[UIApplication sharedApplication] delegate] window]) {//无AlertView
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:nil message:@"登录已失效,是否重新登录!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {//重新登录
//        EMError *error = [[EMClient sharedClient] logout:YES];
//        if (!error) {
//            NSLog(@"退出成功");
//        }
 
     [SysFunctions presentLogonViewController];
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

-(void)startLaugh{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    /* if ([[SysParams sharedInstance] showGuideView]) {
        SPLaughView * laughScroll=[[SPLaughView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,KSCREEN_HEIGHT)];
        [window addSubview:laughScroll];
        [window bringSubviewToFront:laughScroll];
    }else if (![SysParams isLogon]) {
        [SysFunctions presentLogonViewController];
    }*/
    if (![SysParams isLogon]){
        [SysFunctions presentLogonViewController];}
}


@end
