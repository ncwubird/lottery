//
//  UIViewController+PushBackAnimation.h
//  FSCore
//
//  Created by WangWenjie on 15/6/10.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(PushBackAnimation)

/*
 push view controller
 */

- (void)push:(UIViewController *)ctrl;

- (void)push:(NSString *)ctrlName isNib:(BOOL)isnib;

- (void)pushTo:(NSString *)ctrlClassNameWithNoXib data:(id)data;

- (void)push:(NSString *)ctrlName isNib:(BOOL)isnib data:(id)data;

/*
 pop view controller
 */

- (void)pop:(BOOL)animation;

- (void)pop;

- (void)popTo:(NSString *)ctrlName;

/*
 present or dismiss view controller
 */

- (void)presentModalViewController:(UIViewController *)controller;

- (void)dismissModalViewController;


@end
