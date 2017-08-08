//
//  UserViewModel.m
//  JWCore
//
//  Created by JayWong on 16/9/9.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "UserViewModel.h"

#import "UserLogonModel.h"

@implementation UserViewModel

/*登录*/

-(NSDictionary *)logonRequestURLWithAccount:(NSString *)account type:(NSString *)type password:(NSString *)password device:(NSString *)device version:(NSString *)version{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:account forKey:@"account"];
    [params setObject:type forKey:@"type"];
    [params setObject:password forKey:@"password"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];

    return params;
}

-(void)logonTaskWithParams:(NSDictionary *)params{
    [JWHTTPRequest post:KUSER_LOGON args:params target:self succ:^(NSString *responseString) {
        [self logonTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)logonTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
      SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        UserLogonModel *logonModel = [UserLogonModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(logonModel);
    }
}

/*注册验证码*/

-(NSDictionary *)registerCodeRequestURLWithTo:(NSString *)to version:(NSString *)version device:(NSString *)device{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:version forKey:@"version"];
    [params setObject:to forKey:@"to"];
    [params setObject:device forKey:@"device"];
    return params;
}

-(void)registerCodeTaskWithParams:(NSDictionary *)params{
    [JWHTTPRequest post:KUSER_REGISTER_CODE args:params target:self succ:^(NSString *responseString) {
        [self registerCodeTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskExceptionError:error.description];
    }];
    
}

-(void)registerCodeTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        
        self.returnBlock(responseModel);
    }
    
}

/*注册*/

-(NSDictionary *)registerRequestURLWithCode:(NSString *)code device:(NSString *)device version:(NSString *)version account:(NSString *)account password:(NSString *)password type:(NSString *)type{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:code forKey:@"code"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:account forKey:@"account"];
    [params setObject:password forKey:@"password"];
    [params setObject:type forKey:@"type"];
    return params;
}

-(void)registerTaskWithParams:(NSDictionary *)params{
    [JWHTTPRequest post:KUSER_REGISTER args:params target:self succ:^(NSString *responseString) {
        [self registerTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskExceptionError:error.description];
    }];
}

-(void)registerTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        
        self.returnBlock(responseModel);
    }
}

/*忘记密码验证码*/

-(NSDictionary *)forgetPasswordCodeRequestURLWithTo:(NSString *)to device:(NSString *)device version:(NSString *)version{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:to forKey:@"to"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];

    return params;
}

-(void)forgetPasswordCodeTaskWithParams:(NSDictionary *)params{
    [JWHTTPRequest post:KUSER_FORGET_PASSWORD_CODE args:params target:self succ:^(NSString *responseString) {
        [self forgetPasswordCodeTaskResponse:responseString];
    } error:^(NSError *error) {
         [self taskExceptionError:error.description];
    }];
    
}

-(void)forgetPasswordCodeTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
   
    if ([self isCorrectResponse:responseModel]) {
        
        self.returnBlock(responseModel);
    }
}

/*忘记密码*/

-(NSDictionary *)forgetPasswordRequestURLWithCode:(NSString *)code account:(NSString *)account password:(NSString *)password device:(NSString *)device version:(NSString *)version {
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:code forKey:@"code"];
    [params setObject:account forKey:@"account"];
    [params setObject:device forKey:@"device"];
    [params setObject:password forKey:@"password"];
    [params setObject:version forKey:@"version"];
    return params;
}

-(void)forgetPasswordTaskWithParams:(NSDictionary *)params{
    [JWHTTPRequest post:KUSER_FORGET_PASSWORD args:params target:self succ:^(NSString *responseString) {
        [self forgetPasswordTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)forgetPasswordTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        
        self.returnBlock(responseModel);
    }
}
/*退出登录*/

-(NSDictionary *)logonOutURLWithUser_id:(NSString *)user_id token:(NSString *)token  device:(NSString *)device version:(NSString *)version {
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    
    return params;
}

-(void)logonOutTaskWithParams:(NSDictionary *)params{
    [JWHTTPRequest post:KUSER_EXIT args:params target:self succ:^(NSString *responseString) {
        [self forgetPasswordTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)logonOutTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        
        self.returnBlock(responseModel);
    }}
}

/*修改密码*/

-(NSDictionary *)changePasswordURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device version:(NSString *)version oldpwd:(NSString *)oldpwd password:(NSString *)password
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:oldpwd forKey:@"oldpwd"];
    [params setObject:password forKey:@"password"];
    return params;

}

-(void)changePasswordTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KUSER_CHANGE_PASSWORD args:params target:self succ:^(NSString *responseString) {
        [self changePasswordTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)changePasswordTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
       SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
       if ([self isCorrectResponse:responseModel]) {
        
        self.returnBlock(responseModel);
    }}
}

@end
