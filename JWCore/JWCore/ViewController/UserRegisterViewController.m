//
//  UserRegisterViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/8.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "UserRegisterViewController.h"

@interface UserRegisterViewController ()

@end

@implementation UserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self addNavBar:@"此页" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
}
- (IBAction)jump:(id)sender {
    [self push:@"UserLogonViewController" isNib:YES];
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
