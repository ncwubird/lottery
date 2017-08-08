//
//  SysFunctions.m
//  StepMoney
//
//  Created by JayWong on 16/4/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "SysFunctions.h"
#import <ICTKit/UITabBarController+Helper.h>
@implementation SysFunctions

/**
 * 获取AppDelegate
 */
+(AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

/**
 *  获取rootViewController
 */
+(UIViewController *)windowRootViewController{
    return [[[SysFunctions appDelegate] window] rootViewController];
}

/**
 *  获取rootNavigationController
 */
+(UINavigationController *)rootNavController{
    if ([[SysFunctions windowRootViewController] isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)[SysFunctions windowRootViewController];
    }
    return nil;
}

/**
 *  获取NavigationController的根视图
 */
+(UIViewController *)navigationRootViewController{
    return [[SysFunctions rootNavController] topViewController];
}

/**
 *  获取keyWindow
 */
+(UIWindow *)keyWindow{
     return [[UIApplication sharedApplication] keyWindow];
}

/**
 *  获取app版本
 */
+(NSString *)appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/**
 *  X轴缩放比例
 */
-(CGFloat)autolayoutX{
    if(KSCREEN_HEIGHT > 480){
        return KSCREEN_WIDTH/320;
    }
    return 1.0;
}

/**
 *  Y轴缩放比例
 */
-(CGFloat)autolayoutY{
    if(KSCREEN_HEIGHT > 480){
        return KSCREEN_HEIGHT/568;
    }
    return 1.0;
}

/**
 *  隐藏UITabBarViewController中UITabBar
 */
+(void)hiddenTabbar{
    UIViewController * ctrl=[SysFunctions navigationRootViewController];
    if ([ctrl isKindOfClass:[UITabBarController class]]) {
        [(UITabBarController *)ctrl setTabbarHidden:YES animated:YES];
    }
}

/**
 * 显示UITabBarViewController中UITabBar
 */
+(void)showTabbar{
    UIViewController * ctrl=[SysFunctions navigationRootViewController];
    if ([ctrl isKindOfClass:[UITabBarController class]]) {
        [(UITabBarController *)ctrl setTabbarHidden:NO animated:NO];
    }
}

/**
 *  登陆页
 */
+(void)presentLogonViewController{
//    UserLogonViewController * logon=[[UserLogonViewController alloc] init];
//    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:logon];
//    [[SysFunctions rootNavController] presentModalViewController:nav];
}

/**
 *  接口根地址
 */
+(NSString * )getBaseURL{
    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"baseURL"];
}

/**
 *  获取图片路径
 */

+(NSString *)imagePathForShare{
    NSString *imagePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"ShareImage.png"];
    return imagePath;
}

/**
 *  存储图片到沙盒
 */

+ (void) saveImageForShare:(UIImage *)currentImage
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"ShareImage.png"];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

//序列化与反序列化

+(void)archiverWithKey:(NSString *)key data:(id)data{
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:archiveData forKey:key];
}

+(id)unarchiverWithKey:(NSString *)key{
    NSData *archivedDta = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData: archivedDta];
}

/**
 *  生成纯色UIImage
 */

+(UIImage *)generetorImageWithSize:(CGSize)size color:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, size.width,size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *Image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return Image;
}

@end
