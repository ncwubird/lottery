//
//  CommunityViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityHotTopicViewController.h"
#import "CommunityAnnouncementViewController.h"

#import "CommunityTitleView.h"

@interface CommunityViewController ()

@property (nonatomic,retain) CommunityTitleView *navView;
@property (nonatomic,retain) CommunityHotTopicViewController *hotTopicVC;
@property (nonatomic,retain) CommunityAnnouncementViewController *announcementVC;

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:nil leftBtn:BAR_BTN_NONE rightBtn:BAR_BTN_NONE];

    self.navigationItem.titleView = self.navView;
    
    self.announcementVC = [[CommunityAnnouncementViewController alloc]init];
    [self addChildViewController:self.announcementVC];
    [self.view addSubview:self.announcementVC.view];
    [self.announcementVC.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    

    self.hotTopicVC = [[CommunityHotTopicViewController alloc]init];
    [self addChildViewController:self.hotTopicVC];
    [self.view addSubview:self.hotTopicVC.view];
    [self.hotTopicVC.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.hotTopicVC didMoveToParentViewController:self];
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
#pragma mark - SegmentedControlSegment

- (void)titleChoose:(UISegmentedControlSegment *)sender
{
    [self replaceController:_navView.segmentVontrol.selectedSegmentIndex==1?_hotTopicVC:_announcementVC newController:_navView.segmentVontrol.selectedSegmentIndex==1?_announcementVC:_hotTopicVC];
   
}


- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController{
    [self transitionFromViewController:oldController toViewController:newController duration:0.001 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [newController didMoveToParentViewController:self];
    }];

}

#pragma mark - getter
- (CommunityTitleView *)navView{
    if (!_navView) {
        _navView = [[CommunityTitleView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        [_navView.segmentVontrol addTarget:self action:@selector(titleChoose:) forControlEvents:UIControlEventValueChanged];
    }
    return _navView;
}
@end
