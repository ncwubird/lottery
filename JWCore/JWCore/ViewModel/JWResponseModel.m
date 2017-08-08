//
//  JWResponseModel.m
//  StepMoney
//
//  Created by JayWong on 16/4/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "JWResponseModel.h"

@implementation JWResponseModel
@synthesize msg,data,ret;

/**
 *  网络异常
 */
+(void)taskExceptionError:(NSString *)string{
    [JWProgressView showErrorWithStatus:string ? string : @"网络异常，请重新尝试！"];
}

/**
 *  返回数据判断及处理
 */
-(BOOL)isCorrectResponse{
    if ([self.ret isEqualToNumber:STATUS_REQUEST]) {
        if ([self.data.code isEqualToNumber:STATUS_REQUEST_SUCCESS]) {
            return YES;
        }else{
            [self taskError:self.data.msg];
            return NO;
        }
    }else if ([self.ret isEqualToNumber:STATUS_INVALID_TOKEN]){
        NSLog(@"INVALID_TOKEN : %@",self.msg);
        [self showReloginAlert:self];
        [self performSelector:@selector(exchangeLogin) withObject:nil afterDelay:1.5];
       }else if ([self.ret compare:STATUS_INVALID_MINTOKEN] == NSOrderedDescending  && [self.ret compare:STATUS_INVALID_MAXTOKEN] == NSOrderedAscending){
           [self taskError:self.msg];
           return NO;
       }
        return NO;
}

- (void)exchangeLogin
{
//    UINavigationController *nav = [[SysFunctions navigationRootViewController] selectedViewController];
//    [nav popToRootViewControllerAnimated:YES];
//    [UserCacheData logout];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:USER_Quickening_KEY];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:USER_MAMMAL_KEY];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:USER_BIRTHED_KEY];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"KMyDoctor_MODEL_STORAGE"];
//
//    
//    AppDelegateDependencies *dependencies = [[AppDelegateDependencies alloc] init];
//    self.dependencies = dependencies;
//    [self.dependencies installRootViewControllerIntoWindow];
}

/**
 *  获取数据错误
 */
-(void)taskError:(NSString *)string{
    [JWProgressView showErrorWithStatus:string];
}

/**  *  显示token失效,显示提示框
 */
-(void)showReloginAlert:(JWResponseModel *)model{
    [JWProgressView showErrorWithStatus:@"登录已经失效！"];
}

/**
 *  NSObject转json string
 */
-(NSString *)objectToJsonString:(id)object{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end

@implementation Data



@end
