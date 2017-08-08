//
//  SPLaughView.m
//  Stepper
//
//  Created by WangWenjie on 15/10/8.
//  Copyright © 2015年 WWJ. All rights reserved.
//

#import "SPLaughView.h"

@implementation SPLaughView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *homeViewXib = [[NSBundle mainBundle] loadNibNamed:@"SPLaughView" owner:self options:nil];
        self = [homeViewXib objectAtIndex:0];
        [self setFrame:frame];
        
        [self setSubviews];
    }
    return self;
}

-(void)setSubviews{
    [self.pageOneFirstLbl setFont:[UIFont fontWithName:@"Tensentype JiaLiXiYuanJ" size:24]];
    [self.pageOneSecondLbl setFont:[UIFont fontWithName:@"Tensentype JiaLiXiYuanJ" size:24]];
    [self.pageOneThreeLbl setFont:[UIFont fontWithName:@"Tensentype JiaLiXiYuanJ" size:24]];
    [self.pageTwoFirstLbl setFont:[UIFont fontWithName:@"Tensentype JiaLiXiYuanJ" size:24]];
    [self.pageTwoSecondLbl setFont:[UIFont fontWithName:@"Tensentype JiaLiXiYuanJ" size:24]];
    [self.pageTwoThreeLbl setFont:[UIFont fontWithName:@"Tensentype JiaLiXiYuanJ" size:24]];
    [self.pageThreeFirstLbl setFont:[UIFont fontWithName:@"Tensentype JiaLiXiYuanJ" size:24]];
    [self.pageThreeSecondLbl setFont:[UIFont fontWithName:@"Tensentype JiaLiXiYuanJ" size:24]];
    
    [self.scrollView setScrollEnabled:NO];
    [self.scrollView setDelegate:self];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

#pragma mark -XIB Action-

- (IBAction)oneNextAction:(id)sender {
    [self.scrollView setContentOffset:CGPointMake(KSCREEN_WIDTH, 0) animated:YES];
}

- (IBAction)twoNextAction:(id)sender {
    [self resetScrollviewOffsetForNotificationAuth];
}

- (IBAction)gotoSee:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:KSHOW_GUIDE_VIEW];
    
    [self.scrollView setContentOffset:CGPointMake(KSCREEN_WIDTH*3, 0) animated:YES];
    [self performSelector:@selector(resetScrollviewOffsetForLocationAuth) withObject:nil afterDelay:0.5];
}


-(void)resetScrollviewOffsetForNotificationAuth{
    [self.scrollView setContentOffset:CGPointMake(KSCREEN_WIDTH*2, 0) animated:YES];
}

-(void)resetScrollviewOffsetForLocationAuth{
    UINavigationController * navCtrl=[SysFunctions rootNavController];
    [navCtrl.view setHidden:NO];
    
    if([SysParams isLogon]){

    }else{
        [SysFunctions presentLogonViewController];
    }
    [self removeFromSuperview];
}

@end
