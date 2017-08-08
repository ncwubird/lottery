//
//  MyViewModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/30.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "ViewModel.h"

@interface MyViewModel : ViewModel

/*我的主页（个人中心信息）*/
-(NSDictionary *)memberCenterRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version;

-(void)memberCenterInformationTaskWithParams:(NSDictionary *)params;

/*更新用户头像*/
-(NSDictionary *)headPortraitsUpdateRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version avatar:(NSString *)avatar;

-(void)headPortraitsUpdateTaskWithParams:(NSDictionary *)params;

/*更新用户信息*/
-(NSMutableDictionary *)updateUserInfoRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version;

-(void)updateUserInfoTaskWithParams:(NSDictionary *)params;

/*获取医生个人信息*/
-(NSMutableDictionary *)getUserInfoRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version;

-(void)getUserInfoTaskWithParams:(NSDictionary *)params;

/*获取标签*/
-(NSMutableDictionary *)getTagsRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version;

-(void)getTagsTaskWithParams:(NSDictionary *)params;

/*获取银行*/
-(NSMutableDictionary *)getBankListRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version;

-(void)getBankListTaskWithParams:(NSDictionary *)params;

/*获取科室或者职称*/
-(NSMutableDictionary *)getDepartmentListRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version;

-(void)getDepartmentListTaskWithUrl:(NSString *)url Params:(NSDictionary *)params;

/*设置银行卡*/
-(NSMutableDictionary *)setBankCardRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version realname:(NSString *)realname bankNo:(NSString *)bankNo  bankName:(NSString *)bankName bank_id:(NSString *)bank_id;

-(void)setBankCardTaskWithParams:(NSDictionary *)params;

/*获取账户信息*/
-(NSMutableDictionary *)getAccountInfoRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version;

-(void)getAccountInfoTaskWithParams:(NSDictionary *)params;

/*获取账户记录*/
-(NSMutableDictionary *)getAccountRecoderRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device version:(NSString *)version  type:(NSString *)type page:(NSString *)page;

-(void)getAccountRecoderTaskWithParams:(NSDictionary *)params;

/*意见反馈*/
-(NSMutableDictionary *)feedBackRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device version:(NSString *)version  content:(NSString *)content;

-(void)feedBackTaskWithParams:(NSDictionary *)params;


@end
