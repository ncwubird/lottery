//
//  JWRequestExceptionAlertView.m
//  JWCore
//
//  Created by JayWong on 16/9/13.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#define KREQUEST_EXCEPTION_TAG 10001

#import "JWRequestExceptionAlertView.h"

@interface JWRequestExceptionAlertView()

@property (strong,nonatomic) ReloadBlock block;
@property (retain,nonatomic) UIViewController * controller;

@end

@implementation JWRequestExceptionAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -life cycle

-(id)init
{
return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"JWRequestExceptionAlertView" owner:self options:nil] lastObject];
        [self setFrame:frame];
    }
    return self;
}

#pragma mark -events response

- (IBAction)reloadAction:(id)sender {
    if (self.controller) {
            self.block();
    }
}

+(void)showRequestExceptionInController:(UIViewController *)controller reloadBlcok:(ReloadBlock)block{
    JWRequestExceptionAlertView * exceptionAlertView = [controller.view viewWithTag:KREQUEST_EXCEPTION_TAG];
    if (!exceptionAlertView) {
        exceptionAlertView=[[JWRequestExceptionAlertView alloc] initWithFrame:CGRectMake(0, 0, controller.view.frame.size.width, controller.view.frame.size.height)];
        [exceptionAlertView setTag:KREQUEST_EXCEPTION_TAG];
        exceptionAlertView.controller=controller;
        exceptionAlertView.block=block;
        [controller.view addSubview:exceptionAlertView];
    }
    [controller.view bringSubviewToFront:exceptionAlertView];
}

+(void)hiddenRequestExceptionInController:(UIViewController *)controller{
    JWRequestExceptionAlertView * exceptionAlertView = [controller.view viewWithTag:KREQUEST_EXCEPTION_TAG];
    if (exceptionAlertView) {
        [exceptionAlertView removeFromSuperview];
    }
}

@end
