//
//  SysParams.h
//  StepMoney
//
//  Created by JayWong on 16/4/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserLogonModel.h"
@interface SysParams : NSObject
@property (nonatomic,retain) UserLogonModel * logonModel;
@property (nonatomic,assign) BOOL showGuideView;

/**
 *  创建HTTPRequest单例
 */
+(SysParams *)sharedInstance;

/**
 *  保存用户信息
 */
+(void)saveLogonModel:(UserLogonModel *)model;

/**
 *  是否登录
 */
+(BOOL)isLogon;

/**
 *  获取token
 */
+(NSString *)getToken;

/**
 *  获取用户id
 */
+(NSString *)getUserID;

/**
 *  请求基础参数
 */
+(NSDictionary *)baseTaskParams;

@end
