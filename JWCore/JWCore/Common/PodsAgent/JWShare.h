//
//  JWShare.h
//  jingang
//
//  Created by mk on 14-1-15.
//  Copyright (c) 2014年 com.app1580.jingang. All rights reserved.
//
#import "AppDelegate.h"

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"


#define DEFAULT_TITLE       @"大步向钱"
#define DEFAULT_CONTENT     @"大步向钱分享"
#define DEFAULT_URL         @"http://www.dabuxiangqian.cn/download.html"
#define DEFAULT_IMAGE       [[NSBundle mainBundle] pathForResource:@"logo@2x" ofType:@"png"]

@interface JWShare : NSObject

@property SSDKPlatformType logonType;

+ (id)sharedShare;

#pragma mark -分享-

+ (void)shareWithTitle:(NSString *)title content:(NSString *)content image:(NSString *)imgPath url:(NSString *)url;

+ (void)shareWithTitle:(NSString *)title content:(NSString *)content img:(NSString *)imgPath  url:(NSString *)url callback:(void (^)(id infos))callbk;

+ (void)shareNoContainerWithType:(SSDKPlatformType)platType Title:(NSString *)title content:(NSString *)content image:(NSString *)imgPath url:(NSString *)url mediaType:(SSDKContentType)mediaType;

@end
