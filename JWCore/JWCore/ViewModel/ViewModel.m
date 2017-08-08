//
//  ViewModel.m
//  StepMoney
//
//  Created by JayWong on 16/4/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

/**
 *  获取网络的链接状态
 */
-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock{
    BOOL netState = [JWHTTPRequest netWorkReachability];
    netConnectBlock(netState);
}

/**
 *  传入交互的Block块
 */
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _failureBlock = failureBlock;
}

/**
 *  状态值是否正确
 */
-(BOOL)isSuccessStatusCode:(NSNumber *)code{
    return [code isEqualToNumber:STATUS_SUCCESS_CODE] ? YES : NO;
}

/**
 *  获取数据失败
 */
-(void)taskFail:(SPResponseModel *)model{
    if ([self isInvalidToken:model.code]) {
        //token失效处理
    }else{
        [self taskExceptionError:model.msg];
    }
}

/**
 *  token是否失效
 */
-(BOOL)isInvalidToken:(NSNumber *)code{
    return [code isEqualToNumber:STATUS_TOKEN_INVALID] ? YES : NO;
}

/**
 *  获取数据错误
 */
-(void)taskError:(NSString *)string{
    [JWProgressView showErrorWithStatus:@"请求异常,请重新尝试!"];
    self.failureBlock();
}

/**
 *  显示token失效,显示提示框
 */
-(void)showReloginAlert:(SPFirstResponseModel *)model{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:KUSER_INFORMATION];
    [[SysParams sharedInstance]setLogonModel:nil];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:KUSER_LOGIN_INVALID object:nil];
}

/**
 *  错误(服务器或者网络异常)
 */
-(void)taskExceptionError:(NSString *)string{
    [JWProgressView showErrorWithStatus:string];
    //self.failureBlock();

}

/**
 *  返回数据判断及处理
 */
-(BOOL)isCorrectResponse:(SPResponseModel *)responseModel{
    if ([self isSuccessStatusCode:responseModel.code]) {
        return YES;
    }else{
        [self taskFail:responseModel];
        
        if (self.failureBlock) {
            self.failureBlock(responseModel);
        }
    }
    return NO;
}
/**
 *  返回code判断及处理
 */
-(BOOL)codeResponse:(SPFirstResponseModel *)responseModel{
    if ([self isInvalidToken:responseModel.ret]) {
          [JWProgressView dismiss];
        [self showReloginAlert:responseModel];
        
        if (self.failureBlock) {
            self.failureBlock(responseModel);
    
      
             return NO;
        }
    }
    return YES;
}


#pragma mark -object to json string
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
