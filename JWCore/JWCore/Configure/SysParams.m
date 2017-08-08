//
//  SysParams.m
//  StepMoney
//
//  Created by JayWong on 16/4/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "SysParams.h"

__strong static SysParams *params = nil;

@implementation SysParams

/**
 *  创建HTTPRequest单例
 */
+(SysParams *)sharedInstance
{
    
    if (!params) {
        params=[[SysParams alloc] init];
        [SysParams getLogonModel];
        [SysParams getShowGuideView];
    }
    return params;
}

/**
 *  是否显示引导页
 */
+(void)getShowGuideView{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:KSHOW_GUIDE_VIEW]) {
        params.showGuideView=YES;
    }else{
        params.showGuideView=NO;
    }

}
/**
 *  获取用户信息
 */
+(void)getLogonModel{
    id object=[NSObject unarchiverWithKey:KUSER_INFORMATION];
    if ([object isKindOfClass:[UserLogonModel class]]) {
        params.logonModel=object;
    }
}

+(void)saveLogonModel:(UserLogonModel *)model{
    [NSObject archiverWithKey:KUSER_INFORMATION data:model];
    [SysParams getLogonModel];
}

/**
 *  是否登录
 */
+(BOOL)isLogon{
    if ([[SysParams sharedInstance] logonModel]) {
        return YES;
    }
    return NO;
}

/**
 *  获取token
 */
+(NSString *)getToken{
    if ([[SysParams sharedInstance] logonModel]) {
        return params.logonModel.token;
    }
    return @"";
}

/**
 *  获取用户id
 */
+(NSString *)getUserID{
    if ([[SysParams sharedInstance] logonModel]) {
        return params.logonModel.user_id;
    }
    return @"";
}

#pragma mark -请求基础参数

/**
 *  请求基础参数
 */
+(NSDictionary *)baseTaskParams{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    return params;
}


@end
