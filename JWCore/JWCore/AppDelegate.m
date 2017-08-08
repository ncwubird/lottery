//
//  AppDelegate.m
//  JWCore
//
//  Created by JayWong on 16/5/30.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "MyMapLocationManager.h"
#import "APService.h"
@interface AppDelegate ()
@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation AppDelegate

//this breakpoint is UI testing for Reveal.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*初始化弹框样式*/
    [SystemConfigure progressStyleConfigure];
    /*初始化分享模块*/
    [SystemConfigure shareSDKConfigure];
    
     [AMapServices sharedServices].apiKey =@"40f81b44ca54193e0ab89d396c42bdad";
    [MyMapLocationManager sharedInstance];
  
     /*初始化环信模块*/
    EMOptions *options = [EMOptions optionsWithAppkey:@"1109160923115145#ddknows"];
    //options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    /*初始化极光模块*/
    [APService setupWithOption:launchOptions];
    [self registerRemoteNotification];
    //[self localNotifucation];
    
    [self.window setBackgroundColor:[UIColor whiteColor]];
    return YES;
}

#pragma mark -jpush-

-(void)registerRemoteNotification{
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //
    [[EMClient sharedClient] bindDeviceToken:deviceToken];
    // Required
    [APService registerDeviceToken:deviceToken];
    //
    [[NSUserDefaults standardUserDefaults] setObject:[APService registrationID] forKey:@"KREMOTE_NOTIFICATION_DEVICE_TOKEN"];
    NSLog(@"register ID : %@",[APService registrationID]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
    //
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    //
    if ([[userInfo objectForKey:@"type"] isEqualToString:@"daoqi"]) {
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
      [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
