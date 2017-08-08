//
//  SystemConfigure.m
//  JWCore
//
//  Created by JayWong on 16/5/31.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "SystemConfigure.h"
/*umeng*/
#import <UMMobClick/MobClick.h>
/*shareSDK*/
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>     //QQ和QQ空间SDK头文件
#import <TencentOpenAPI/QQApiInterface.h>   //QQ和QQ空间SDK头文件
#import "WXApi.h"

@implementation SystemConfigure

+(void)httpRequestConfigure{
    [JWHTTPRequest sharedInstance];
    [JWHTTPRequest setPlatform:ARGS_SLANT];
}

+(void)progressStyleConfigure{
    [JWProgressView initStyle];
}

+(void)umengAnalyticsConfigure{
    UMConfigInstance.appKey = @"";              //umeng平台设置并获取
    UMConfigInstance.channelId = @"App Store";  //应用的渠道标识
    UMConfigInstance.eSType = E_UM_NORMAL;      // 仅适用于游戏场景
    UMConfigInstance.ePolicy=BATCH;             // 发送策略
    
}

+(void)shareSDKConfigure{
    //添加新浪微博网页  http://open.weibo.com
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    //添加QQ应用  注册网址   http://mobile.qq.com/api/
    
    /*appkey及appSecret来自大步向钱*/
    [ShareSDK registerApp:@"136f2eafafce"
     
            activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            ]
            onImport:^(SSDKPlatformType platformType){
                switch (platformType){
                    case SSDKPlatformTypeWechat:
                        [ShareSDKConnector connectWeChat:[WXApi class]];
                        break;
                    case SSDKPlatformTypeQQ:
                        [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                        break;
                        default:
                        break;
                }
            }onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
              switch (platformType){
                                    case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx2a18a6d4319da707"
                                       appSecret:@"a997a9c86f2328adaa4f826acc6bdd56"];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"1104846580"
                                      appKey:@"Ox0UnOqOYp8rEpxQ"
                                    authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
        }];
}

@end
