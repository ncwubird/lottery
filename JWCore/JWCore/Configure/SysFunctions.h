//
//  SysFunctions.h
//  StepMoney
//
//  Created by JayWong on 16/4/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface SysFunctions : NSObject

/**
 * 获取AppDelegate
 */
+(AppDelegate *)appDelegate;

/**
 *  获取rootViewController
 */
+(UIViewController *)windowRootViewController;

/**
 *  获取rootNavigationController
 */
+(UINavigationController *)rootNavController;

/**
 *  获取NavigationController的根视图
 */
+(UIViewController *)navigationRootViewController;

/**
 *  获取keyWindow
 */
+(UIWindow *)keyWindow;

/**
 *  获取app版本
 */
+(NSString *)appVersion;

/**
 *  隐藏UITabBarViewController中UITabBar
 */
+(void)hiddenTabbar;

/**
 * 显示UITabBarViewController中UITabBar
 */
+(void)showTabbar;

/**
 *  登陆页
 */
+(void)presentLogonViewController;

/**
 *  接口根地址
 */
+(NSString * )getBaseURL;

/**
 *  获取图片路径
 */

+(NSString *)imagePathForShare;

/**
 *  存储图片到沙盒
 */

+ (void) saveImageForShare:(UIImage *)currentImage;

//序列化与反序列化

+(void)archiverWithKey:(NSString *)key data:(id)data;

+(id)unarchiverWithKey:(NSString *)key;

/**
 *  生成纯色UIImage
 */

+(UIImage *)generetorImageWithSize:(CGSize)size color:(UIColor *)color;

@end
