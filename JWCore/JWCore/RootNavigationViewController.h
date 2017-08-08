//
//  RootNavigationViewController.h
//  JWCore
//
//  Created by JayWong on 16/9/13.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootNavigationViewController : UINavigationController

{
    EMConnectionState _connectionState;
}

- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)setupUnreadMessageCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)playSoundAndVibration;

- (void)showNotificationWithMessage:(EMMessage *)message;
@end
