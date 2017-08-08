//
//  MySettingViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/26.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MySettingViewController.h"
#import "UserViewModel.h"

@interface MySettingViewController ()

@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"设置" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -xib action
- (IBAction)resetPassword:(id)sender {
    [self push:@"UserResetPasswordViewController" isNib:YES];
}
- (IBAction)Feedback:(id)sender {
     [self push:@"MyFeedBackViewController" isNib:YES];
}
- (IBAction)aboutUs:(id)sender {
    WebViewController *webController = [[WebViewController alloc]init];
    webController.url =KHOME_MEMBERE_ABOUTUS;
    [self.navigationController pushViewController:webController animated:YES];

}
- (IBAction)exit:(id)sender {
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
    }

        [self exitRequest];
    
}

#pragma mark -request

-(void)exitRequest{
    UserViewModel * viewModel=[UserViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
           
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:KUSER_INFORMATION];
            [[SysParams sharedInstance]setLogonModel:nil];
           
            [self.navigationController popToRootViewControllerAnimated:YES];
            [SysFunctions presentLogonViewController];        }
    } WithFailureBlock:^{
        
    }];
    NSDictionary * params=[viewModel logonOutURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]];
   
    [viewModel logonOutTaskWithParams:params];
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
