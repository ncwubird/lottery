//
//  FindViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self addNavBar:@"发现" leftBtn:BAR_BTN_NONE rightBtn:BAR_BTN_NONE];
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
