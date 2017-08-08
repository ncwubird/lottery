//
//  JWHTTPRequest.m
//  StepMoney
//
//  Created by JayWong on 16/4/15.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "JWHTTPRequest.h"
#import <AFHTTPSessionManager.h>
#import "JWProgressView.h"

__strong static JWHTTPRequest *request = nil;
static ARGS_TYPE platFormStore=ARGS_SLANT;
static AFHTTPSessionManager *manager;

@interface JWHTTPRequest()

@property (nonatomic,retain) AFHTTPSessionManager * httpSessionManager;

@end

@implementation JWHTTPRequest


+(AFHTTPSessionManager *)sharedHttpSessionManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        //manager.requestSerializer.timeoutInterval = 10.0;
    });
    
    return manager;
}

/**
 *  监测网络的可链接性
 */
+ (BOOL) netWorkReachability
{
    __block BOOL netState = NO;
    
   [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
       NSLog(@"%ld",(long)status);
       
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return netState;
}

/**
 *  获取HTTP请求根地址
 */
+(NSString * )baseURL{
    NSString *baseUrl=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"baseURL"];
    return baseUrl ? baseUrl : nil;
}

/**
 *  获取图片服务器根地址
 */
+(NSString *)imageURL{
    NSString *imageUrl=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"imgURL"];
    return imageUrl ? imageUrl : nil;
}

/**
 *    获得APPkey
 *    @returns 获得有服务端分配的AppKey
 */
+ (NSString *)appKey
{
    NSString *appKey =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"appKey"];
    return appKey==nil ? @"" : appKey;
}
/**
 *  设置HTTP请求根地址
 */
+ (NSString *)setupBaseUrl:(NSString *)api
{
    NSMutableString *apiurl = [NSMutableString stringWithString:[JWHTTPRequest baseURL]];
    [apiurl appendString:api];
    if (![[JWHTTPRequest appKey] isEqualToString:@""] && ([JWHTTPRequest appKey] != nil)) {
        if (platFormStore == ARGS_SLANT) {
            [apiurl appendFormat:@"/appKey/%@", [JWHTTPRequest appKey]];
        }
        
        if (platFormStore == ARGS_QUESTION) {
            [apiurl appendFormat:@"?appKey=%@", [JWHTTPRequest appKey]];
        }
    }
    
    return apiurl;
}

/**
 *    设置平台信息
 *    @param platform 平台信息，参看 ARGS_TYPE 的定义
 */
+ (void)setPlatform:(ARGS_TYPE)platform{
    platFormStore = platform;
}

/**
 *  创建JWHTTPRequest单例
 */
+ (JWHTTPRequest *)sharedInstance
{
    
    if (!request) {
        request = [[super allocWithZone:NULL]init];
        request.httpSessionManager=[AFHTTPSessionManager manager];
        request.httpSessionManager.requestSerializer=[AFHTTPRequestSerializer serializer];
        request.httpSessionManager.responseSerializer=[AFHTTPResponseSerializer serializer];
    }
    return request;
}

/**
 *POST请求
 */

+ (void)post:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error {
    
    [JWHTTPRequest post:api args:args target:target succ:succ error:error loading:YES];
}


+ (void)post:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error loading:(BOOL)loading{
    
    [JWHTTPRequest sharedInstance];
    
    if (![request findString:api subString:@"http"]) {
        api = [JWHTTPRequest setupBaseUrl:api];
    }

    /**
     *  基础网络连接
     */
    [request logRequest:api args:args type:@"post"];
    
    [request.httpSessionManager POST:api parameters:args progress:^(NSProgress * _Nonnull uploadProgress) {
        if (loading) {
            [JWProgressView show];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [JWProgressView dismiss];
        NSString *responseString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if(responseObject) succ(responseString);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        error(err);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
}

/**
 *  GET请求
 */

+ (void)get:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error{
    
    [JWHTTPRequest get:api args:args target:target succ:succ error:error loading:YES];
}

+ (void)get:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error loading:(BOOL)loading{
    
    [JWHTTPRequest sharedInstance];
    
    /*
     设置参数拼接方式
     */
    NSMutableDictionary *postArgs = [NSMutableDictionary dictionary];
    
    [postArgs addEntriesFromDictionary:args];
    
    NSMutableString *subArg = [NSMutableString string];
    
    NSString *fmtArgs = @"";
    
    if (platFormStore == ARGS_SLANT) {
        fmtArgs = @"/%@/%@";
    }
    
    if (platFormStore == ARGS_QUESTION) {
        fmtArgs = @"&%@=%@";
    }
    
    for (NSString *key in [args allKeys]) {
        if ([args objectForKey:key] == nil) {
            continue;
        }
        [subArg appendFormat:fmtArgs, key, [args objectForKey:key]];
    }
    
    if (![[JWHTTPRequest appKey] isEqualToString:@""] && ([JWHTTPRequest appKey] != nil)) {
        if (platFormStore == ARGS_SLANT) {
            fmtArgs = @"%@/appKey/%@%@";
        }
        
        if (platFormStore == ARGS_QUESTION) {
            fmtArgs = @"%@?appKey=%@%@";
        }
        
        NSString *baseUrl = [JWHTTPRequest baseURL];
        if ([api hasPrefix:@"http://"] || [api hasPrefix:@"https://"] ) {
            baseUrl = @"";
        }
        
        api = [baseUrl stringByAppendingFormat:fmtArgs, api, [JWHTTPRequest appKey], subArg];
    } else {
        if (platFormStore == ARGS_SLANT) {
            fmtArgs = @"%@%@";
        }
        
        if (platFormStore == ARGS_QUESTION) {
            fmtArgs = @"%@?%@";
        }
        
        if ([subArg hasPrefix:@"&"]) {
            [subArg deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        
        NSString *baseUrl = [JWHTTPRequest baseURL];
        if ([api hasPrefix:@"http://"] || [api hasPrefix:@"https://"] ) {
            baseUrl = @"";
        }
        api = [baseUrl stringByAppendingFormat:fmtArgs, api, subArg];
    }
    
    api = [api stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    /**
     *基础网络连接
     */
    [request logRequest:api args:args type:@"get"];
    
    [request.httpSessionManager GET:api parameters:args progress:^(NSProgress * _Nonnull downloadProgress) {
        if (loading) {
            [JWProgressView show];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if(responseObject) succ(responseString);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        error(err);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

/**
 *  控制台打印请求信息
 */
-(void)logRequest:(NSString *)api args:(id)args type:(NSString * )type{
    NSLog(@"\ntype:%@\napi:%@\narguments:%@",type,api,args);
}

/**
 *  查找字符串
 */
-(BOOL)findString:(NSString *)string subString:(NSString *)subString{
    if ([string rangeOfString:subString].location != NSNotFound) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -request no shareinstance

/**
 *  独立的post请求
 */
+ (void)postNoShareInstance:(NSString *)api args:(id)args target:(id)target succ:(HTTPRequestSuccessBlock)succ error:(HTTPRequestFailureBlock)error{
    
    JWHTTPRequest * httpRequest=[[JWHTTPRequest alloc] init];
    httpRequest.httpSessionManager=[self sharedHttpSessionManager];
    httpRequest.httpSessionManager.requestSerializer=[AFHTTPRequestSerializer serializer];
    httpRequest.httpSessionManager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    if (![httpRequest findString:api subString:@"http"]) {
        api = [JWHTTPRequest setupBaseUrl:api];
    }
    
    /**
     *  基础网络连接
     */
    [httpRequest logRequest:api args:args type:@"post"];
    
    [httpRequest.httpSessionManager POST:api parameters:args progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        if(responseObject) succ(responseString);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        error(err);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
}

@end
