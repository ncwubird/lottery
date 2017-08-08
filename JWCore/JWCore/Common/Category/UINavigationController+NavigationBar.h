//
//  UINavigationController+NavigationBar.h
//  JWCore
//
//  Created by JayWong on 16/9/2.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController(NavigationBar)

-(void)setupNavBarBackimage:(UIImage *)backImage lineImage:(UIImage *)lineImage;

-(void)clearNavigationBar;

/*status bar back*/

-(void)statusBarBackgroundWithColor:(UIColor *)color;

/**
 查找ctrl
 */

-(UIViewController *)isExistCtrlInNavCtrl:(NSString *)ctrlStr;
@end
