//
//  UINavigationController+NavigationBar.m
//  JWCore
//
//  Created by JayWong on 16/9/2.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#define KSTATUS_BACK_VIEW_TAG 10000001

#import "UINavigationController+NavigationBar.h"

@implementation UINavigationController(NavigationBar)

-(void)setupNavBarBackimage:(UIImage *)backImage lineImage:(UIImage *)lineImage;{
    [self.navigationBar setBackgroundImage:backImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = lineImage;
}

-(void)clearNavigationBar{
    [self.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
}

/*status bar back*/

-(void)statusBarBackgroundWithColor:(UIColor *)color{
    UIView * background=[self.view viewWithTag:KSTATUS_BACK_VIEW_TAG];
    if (background) {
        [background setBackgroundColor:color];
    }else{
        background=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 20)];
        [background setTag:KSTATUS_BACK_VIEW_TAG];
        [background setBackgroundColor:color];
        [self.view addSubview:background];
    }
}

/**
 查找ctrl
 */

-(UIViewController *)isExistCtrlInNavCtrl:(NSString *)ctrlStr{
    for(UIViewController * ctrl in self.viewControllers){
        if ([ctrl isKindOfClass:NSClassFromString(ctrlStr)]) {
            return ctrl;
        }
    }
    return nil;
}
@end
