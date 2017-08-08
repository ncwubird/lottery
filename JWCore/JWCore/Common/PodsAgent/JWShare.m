//
//  JWShare.m
//  jingang
//
//  Created by mk on 14-1-15.
//  Copyright (c) 2014年 com.app1580.jingang. All rights reserved.
//

#import "JWShare.h"

@implementation JWShare

static JWShare *sharedInstance = nil;

+ (id)sharedShare
{
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
	return sharedInstance;
}

- (id)init
{
	if (sharedInstance == nil) {
		self = [super init];
	}
	return self;
}

#pragma mark -分享-

+ (void)shareWithTitle:(NSString *)title content:(NSString *)content image:(NSString *)imgPath url:(NSString *)url
{
    [self shareWithTitle:title content:content img:imgPath url:url callback:nil];
}

+ (void)shareWithTitle:(NSString *)title content:(NSString *)content img:(NSString *)imgPath  url:(NSString *)url callback:(void (^)(id infos))callbk
{
    title=title ? title : DEFAULT_TITLE;
    content=content ? content : DEFAULT_CONTENT;
    url=url ? url : DEFAULT_URL;
    imgPath=imgPath ? imgPath : DEFAULT_IMAGE;
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imgPath];
    //1、创建分享参数
    NSArray* imageArray = @[image];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:content
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto];
        //2、分享
        [ShareSDK share:SSDKPlatformTypeUnknown parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    [JWProgressView showSuccessWithStatus:@"分享成功"];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    [JWProgressView showErrorWithStatus:@"分享失败"];
                    break;
                }
                default:
                    break;
            }
        }];
    }
}

+ (void)shareNoContainerWithType:(SSDKPlatformType)platType Title:(NSString *)title content:(NSString *)content image:(NSString *)imgPath url:(NSString *)url mediaType:(SSDKContentType)mediaType
{
    title=title ? title : DEFAULT_TITLE;
    content=content ? content : DEFAULT_CONTENT;
    url=url ? url : DEFAULT_URL;
    imgPath=imgPath ? imgPath : DEFAULT_IMAGE;
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imgPath];
    //1、创建分享参数
    NSArray* imageArray = @[image];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:content
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto];
        //2、分享
        [ShareSDK share:platType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    [JWProgressView showSuccessWithStatus:@"分享成功"];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    [JWProgressView showErrorWithStatus:@"分享失败"];
                    
                    break;
                }
                default:
                    break;
            }
            
        }];
    }
}

@end

