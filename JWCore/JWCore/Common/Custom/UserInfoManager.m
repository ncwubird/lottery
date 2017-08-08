//
//  UserInfoManager.m
//  gloryShip
//
//  Created by WangWenjie on 15/1/4.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import "UserInfoManager.h"

@interface UserInfoManager()

@property (strong,nonatomic) NSMutableDictionary * userInfo;

@end

@implementation UserInfoManager

static UserInfoManager * manager;

/**
 *  创建实例对象
 */
+(UserInfoManager *)shareInstance{
    if (!manager) {
        manager=[[UserInfoManager alloc] init];
        manager.userInfo=[NSObject unarchiverWithKey:KUSER_INFO];
    }
    return manager;
}

/**
 *  保存和删除
 */
-(void)saveWithUserInfo:(NSDictionary *)userInfo{
    [NSObject archiverWithKey:KUSER_INFO data:userInfo];
}

-(void)deleteUserInfo{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUSER_INFO];
    manager.userInfo=nil;
}

/**
 *  用户是否登录
 */

-(BOOL)isLogonOn{
    return  manager.userInfo || [manager.userInfo isEqual:[NSNull null]] ? YES : NO;
}

/**
 *  取值
 */

-(NSDictionary *)userInfoKeyDictionary{
    NSString * path=[[NSBundle mainBundle] pathForResource:@"UserInfo" ofType:@"plist"];
    NSDictionary * keyDictionary=[[NSDictionary alloc] initWithContentsOfFile:path];
    return keyDictionary;
}

-(NSString *)getToken{
    return [manager.userInfo objectForKey:[[manager userInfoKeyDictionary] objectForKey:@"TOKEN"]];
}

-(NSString *)getID{
    return [manager.userInfo objectForKey:[[manager userInfoKeyDictionary] objectForKey:@"ID"]];
}

-(NSString *)getName{
    return [manager.userInfo objectForKey:[[manager userInfoKeyDictionary] objectForKey:@"NAME"]];
}

-(NSString *)getHeader{
    return [manager.userInfo objectForKey:[[manager userInfoKeyDictionary] objectForKey:@"HEADER"]];
}

-(NSString *)getMobile{
    return [manager.userInfo objectForKey:[[manager userInfoKeyDictionary] objectForKey:@"MOBILE"]];
}

-(NSString *)getValueWithKey:(NSString *)key{
    return [manager.userInfo objectForKey:[[manager userInfoKeyDictionary] objectForKey:key]];
}

@end
