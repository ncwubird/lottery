//
//  HTTPRequest.m
//  VIPER-OC
//
//  Created by ddknows on 2016/11/30.
//  Copyright © 2016年 ddknows. All rights reserved.
//

#import "JWHTTPRequest.h"
#import "HTTPRequest.h"

@implementation HTTPRequest

#pragma mark -user login

/*登录*/
- (void)logonTaskWithAccount:(NSString *)account password:(NSString *)password{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:account forKey:@"account"];
    [params setObject:password forKey:@"password"];
    [params setObject:@"ios" forKey:@"device"];
    [params setObject:[SysFunctions appVersion] forKey:@"version"];
    
    [JWHTTPRequest post:KUSER_LOGON args:params target:self succ:^(NSString *responseString) {
        NSLog(@"%@",responseString);
        self.returnBlock(responseString);
    } error:^(NSError *error) {
        self.failureBlock(error);
    }];
}


@end
