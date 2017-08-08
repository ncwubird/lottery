//
//  RootTabbarViewController.m
//  JWCore
//
//  Created by JayWong on 16/9/2.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "RootTabbarViewController.h"
#import "MessageHomeViewController.h"
#import "PatientHomeViewController.h"
#import "MyHomeViewController.h"
#import "ConversationListController.h"

#import "UINavigationController+NavigationBar.h"
#import <ICTKit/UITabBarController+Helper.h>

@interface RootTabbarViewController ()

@end

@implementation RootTabbarViewController

#pragma mark -life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setupTabBarBackColorAndLineColor];
    
    [self addSubViewController];
    
    [self setupTabBarItem];
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


-(void)setupTabBarBackColorAndLineColor{
    [self.tabBar setShadowImage:[SysFunctions generetorImageWithSize:CGSizeMake(KSCREEN_WIDTH, 1) color:[UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0]]];
    [self.tabBar setBackgroundImage:[SysFunctions generetorImageWithSize:CGSizeMake(KSCREEN_WIDTH, 49) color:[UIColor colorWithRed:253.0/255.0 green:253.0/255.0 blue:253.0/255.0 alpha:1.0]]];
}

-(void)addSubViewController{
    ConversationListController *messageVc = [[ConversationListController alloc]init];
    UINavigationController * messageNav=[[UINavigationController alloc] initWithRootViewController:messageVc];
    //[messageNav setToolbarHidden:YES animated:NO];

    UINavigationController * patientNav=[[UINavigationController alloc] initWithRootViewController:[[PatientHomeViewController alloc]init]];
    
    UINavigationController * myNav=[[UINavigationController alloc] initWithRootViewController:[[MyHomeViewController alloc]init]];
    
    
    self.viewControllers=@[messageNav,patientNav,myNav];
    
    [self setSelectedViewController:messageNav];
}

-(void)setupTabBarItem{
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    item0.imageInsets=UIEdgeInsetsMake(-3, 0,3, 0);
    item1.imageInsets=UIEdgeInsetsMake(-3, 0,3, 0);
    item2.imageInsets=UIEdgeInsetsMake(-3, 0,3, 0);
    
    item0.title=@"消息";
    item1.title=@"患者";
    item2.title=@"我的";
    
    item0.selectedImage = [[UIImage imageNamed:@"tool_bar_1_2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.image = [[UIImage imageNamed:@"tool_bar_1_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item1.selectedImage = [[UIImage imageNamed:@"tool_bar_2_2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"tool_bar_2_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item2.selectedImage = [[UIImage imageNamed:@"tool_bar_3_2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"tool_bar_3_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[@"#A0A0A0" hexColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica" size:12.0], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[@"#009BFF" hexColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica" size:12.0], NSFontAttributeName,nil] forState:UIControlStateSelected];
}


@end
