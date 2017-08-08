//
//  UserInfoManager.h
//  gloryShip
//
//  Created by WangWenjie on 15/1/4.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#define KUSER_INFO  @"USER_INFORMATION_KEY"

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

/**
 *  创建实例对象
 */
+(UserInfoManager *)shareInstance;

/**
 *  保存和删除
 */
-(void)saveWithUserInfo:(NSDictionary *)userInfo;
-(void)deleteUserInfo;

/**
 *  用户是否登录
 */
-(BOOL)isLogonOn;

/**
 *  取值
 */
-(NSDictionary *)userInfoKeyDictionary;
-(NSString *)getToken;
-(NSString *)getID;
-(NSString *)getName;
-(NSString *)getHeader;
-(NSString *)getMobile;
-(NSString *)getValueWithKey:(NSString *)key;

@end
