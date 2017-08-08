//
//  AppDelegate.h
//  Lottery
//
//  Created by 苟晓浪 on 2017/8/8.
//  Copyright © 2017年 com.yunkanghuigu.lottery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

