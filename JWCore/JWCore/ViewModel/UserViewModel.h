//
//  UserViewModel.h
//  JWCore
//
//  Created by JayWong on 16/9/9.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "ViewModel.h"

@interface UserViewModel : ViewModel

/*登录*/

-(NSDictionary *)logonRequestURLWithAccount:(NSString *)account type:(NSString *)type password:(NSString *)password device:(NSString *)device version:(NSString *)version;

-(void)logonTaskWithParams:(NSDictionary *)params;

/*注册验证码*/

-(NSDictionary *)registerCodeRequestURLWithTo:(NSString *)to version:(NSString *)version device:(NSString *)device;

-(void)registerCodeTaskWithParams:(NSDictionary *)params;

/*注册*/

-(NSDictionary *)registerRequestURLWithCode:(NSString *)code device:(NSString *)device version:(NSString *)version account:(NSString *)account password:(NSString *)password type:(NSString *)type;

-(void)registerTaskWithParams:(NSDictionary *)params;

/*忘记密码验证码*/

-(NSDictionary *)forgetPasswordCodeRequestURLWithTo:(NSString *)to device:(NSString *)device version:(NSString *)version;

-(void)forgetPasswordCodeTaskWithParams:(NSDictionary *)params;

/*忘记密码*/

-(NSDictionary *)forgetPasswordRequestURLWithCode:(NSString *)code account:(NSString *)account password:(NSString *)password device:(NSString *)device version:(NSString *)version;

-(void)forgetPasswordTaskWithParams:(NSDictionary *)params;

/*退出账户*/

-(NSDictionary *)logonOutURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device version:(NSString *)version;

-(void)logonOutTaskWithParams:(NSDictionary *)params;

/*修改密码*/

-(NSDictionary *)changePasswordURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device version:(NSString *)version oldpwd:(NSString *)oldpwd password:(NSString *)password;

-(void)changePasswordTaskWithParams:(NSDictionary *)params;



@end
