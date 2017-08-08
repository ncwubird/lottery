//
//  MessageViewModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "ViewModel.h"

@interface MessageViewModel : ViewModel

/*获取环信ID信息*/

-(void)getEMobInfoTaskWithParams:(NSDictionary *)params;

/*获取用户所有系统消息*/
-(NSDictionary *)getSystemMessageRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version;

-(void)getSystemMessageTaskWithParams:(NSDictionary *)params;








@end
