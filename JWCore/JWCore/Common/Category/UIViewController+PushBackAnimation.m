//
//  UIViewController+PushBackAnimation.m
//  FSCore
//
//  Created by WangWenjie on 15/6/10.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import "UIViewController+PushBackAnimation.h"

@implementation UIViewController(PushBackAnimation)

- (void)push:(UIViewController *)ctrl
{
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)push:(NSString *)ctrlName isNib:(BOOL)isnib
{
    [self push:ctrlName isNib:isnib data:nil];
}

- (void)pushTo:(NSString *)ctrlClassNameWithNoXib data:(id)data
{
    [self push:ctrlClassNameWithNoXib isNib:NO data:data];
}

- (void)push:(NSString *)ctrlName isNib:(BOOL)isnib data:(id)data
{
    id controller = nil;
    if (isnib) {
        controller = [[NSClassFromString(ctrlName) alloc] initWithNibName:ctrlName bundle:nil];
    } else {
        controller = [[NSClassFromString(ctrlName) alloc] init];
    }
    if (data != nil) {
        //未处理
    }
    [self push:controller];
}

- (void)pop:(BOOL)animation
{
    [self.navigationController popViewControllerAnimated:animation];
}

- (void)pop{
    [self pop:YES];
}

- (void)popTo:(NSString *)ctrlName
{
    NSArray *pops = self.navigationController.viewControllers;
    
    for (UIViewController *ctrl in pops) {
        if ([[[ctrl class] description] isEqualToString:ctrlName]) {
            [self.navigationController popToViewController:ctrl animated:YES];
            break;
        }
    }
}

- (void)presentModalViewController:(UIViewController *)controller
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0
    [self presentViewController:controller animated:YES completion:^{}];
#else
    [self presentModalViewController:controller animated:YES];
#endif
}

- (void)dismissModalViewController
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >=  __IPHONE_5_0
    [self dismissViewControllerAnimated:YES completion:^{}];
#else
    [self dismissModalViewControllerAnimated:YES];
#endif
}

@end
