//
//  JWProgressView.m
//  StepMoney
//
//  Created by JayWong on 16/4/15.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "JWProgressView.h"
#import <SVProgressHUD/SVProgressHUD.h>

__strong static JWProgressView *progressView = nil;

@implementation JWProgressView

/**
 *  创建JWProgressView单例
 */
+(JWProgressView *)sharedInstance
{
    
    if (!progressView) {
        progressView=[[JWProgressView alloc] init];
        
    }
    return progressView;
}

+(void)initStyle{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithHue:0.0 saturation:0.0 brightness:0.0 alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setRingNoTextRadius:20];
    [SVProgressHUD setRingThickness:3];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
}

+(void)show{
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString*)string{
    [SVProgressHUD showWithStatus:string];
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay{
    [SVProgressHUD dismissWithDelay:delay];
}

+ (void)showInfoWithStatus:(NSString*)string{
    [SVProgressHUD showErrorWithStatus:string];
}

+ (void)showSuccessWithStatus:(NSString*)string{
    [SVProgressHUD showSuccessWithStatus:string];
}

+ (void)showErrorWithStatus:(NSString*)string{
    [SVProgressHUD showErrorWithStatus:string];
}

+ (void)showImage:(UIImage*)image status:(NSString*)string{
    [SVProgressHUD showImage:image status:string];
}

@end
