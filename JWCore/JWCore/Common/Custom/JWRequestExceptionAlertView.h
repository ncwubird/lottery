//
//  JWRequestExceptionAlertView.h
//  JWCore
//
//  Created by JayWong on 16/9/13.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReloadBlock) ();

@interface JWRequestExceptionAlertView : UIView

+(void)showRequestExceptionInController:(UIViewController *)controller reloadBlcok:(ReloadBlock)block;

+(void)hiddenRequestExceptionInController:(UIViewController *)controller;

@end
