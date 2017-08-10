//
//  MyViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UIAlertViewDelegate>

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"nav_clear" leftBtn:BAR_BTN_NONE rightBtn:BAR_BTN_NONE];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18],NSFontAttributeName,nil]];
    self.navigationItem.title = @"我的";
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

#pragma mark - button

- (IBAction)payAction:(id)sender {
}
- (IBAction)payRecoderAction:(id)sender {
}
- (IBAction)attendanceAction:(id)sender {
}
- (IBAction)buiedAction:(id)sender {
}
- (IBAction)playIntroductionAction:(id)sender {
}

- (IBAction)contactUsAction:(id)sender {
}
- (IBAction)bindMobileAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"绑定手机号" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *tf=[alertView textFieldAtIndex:0];
        NSLog(@"%@",tf.text);
    }
   
}
@end
