//
//  MessageViewModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MessageViewModel.h"
#import "MessageHomeModel.h"
#import "MessageSystemModel.h"


@implementation MessageViewModel

/*获取环信ID信息*/

-(void)getEMobInfoTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KUSER_MESSAGE_ALLINFO args:params target:self succ:^(NSString *responseString) {
        [self getEMobInfoTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)getEMobInfoTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
      SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
      if ([self isCorrectResponse:responseModel]) {
        
        MessageHomeModel *model =[MessageHomeModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
    }
    }
}

/*获取用户所有系统消息*/
-(NSDictionary *)getSystemMessageRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    
    return params;

}

-(void)getSystemMessageTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KMESSAGE_SYSTEM_ALLINFO args:params target:self succ:^(NSString *responseString) {
        [self getSystemMessageTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)getSystemMessageTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
        SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
        if ([self isCorrectResponse:responseModel]) {
            
            MessageSystemModel *model =[MessageSystemModel mj_objectWithKeyValues:responseModel.info];
            self.returnBlock(model);
        }
    }
}




@end
