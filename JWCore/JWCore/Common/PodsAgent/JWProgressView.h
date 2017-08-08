//
//  JWProgressView.h
//  StepMoney
//
//  Created by JayWong on 16/4/15.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWProgressView : NSObject

+(void)initStyle;

+(void)show;

+ (void)showWithStatus:(NSString*)string;

+ (void)dismiss;

+ (void)dismissWithDelay:(NSTimeInterval)delay;

+ (void)showInfoWithStatus:(NSString*)string;

+ (void)showSuccessWithStatus:(NSString*)string;

+ (void)showErrorWithStatus:(NSString*)string;

+ (void)showImage:(UIImage*)image status:(NSString*)string;

@end
