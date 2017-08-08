//
//  JWHTTPRequest.h
//  StepMoney
//
//  Created by JayWong on 16/4/15.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^HTTPRequestSuccessBlock) (NSString * responseDic);
typedef void (^HTTPRequestFailureBlock) (NSError * error);

typedef NS_ENUM(NSInteger, ARGS_TYPE) {
    ARGS_QUESTION,     /* 参数类似于 ?arg1=1&arg2=2 */
    ARGS_SLANT         /* 参数类似于 /arg1/1/arg2/2 */
};

@interface JWHTTPRequest : NSObject

/**
 *  监测网络的可链接性
 */
+ (BOOL) netWorkReachability;

/**
 *    设置平台信息
 *    @param platform 平台信息，参看 ARGS_TYPE 的定义
 */
+ (void)setPlatform:(ARGS_TYPE)platform;

/**
 *  创建JWHTTPRequest单例
 */
+(JWHTTPRequest *)sharedInstance;

/**
 *POST请求
 */

+ (void)post:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error;

+ (void)post:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error loading:(BOOL)loading;

/**
 *  GET请求
 */

+ (void)get:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error;

+ (void)get:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error loading:(BOOL)loading;

/**
 *  独立的post请求
 */
+ (void)postNoShareInstance:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error;
@end
