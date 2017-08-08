//
//  MyViewModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/30.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyViewModel.h"
#import "MyHomeModel.h"
#import "MyBankModel.h"
#import "MyDepartmentModel.h"
#import "MyTagsModel.h"
#import "MyAccountInfoModel.h"
#import "MyAccountRecoderModel.h"
@implementation MyViewModel

/*我的主页（个人中心）*/

-(NSDictionary *)memberCenterRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    
    return params;
}

-(void)memberCenterInformationTaskWithParams:(NSDictionary *)params{
    [JWHTTPRequest post:KHOME_MEMBERCENTER args:params target:self succ:^(NSString *responseString) {
        [self memberCenterInformationTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)memberCenterInformationTaskResponse:(NSString *)responseString{
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
      
        self.returnBlock(responseModel);
    }}
}

/*更新头像*/
-(NSDictionary *)headPortraitsUpdateRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version avatar:(NSString *)avatar
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:avatar forKey:@"avatar"];
    return params;

}

-(void)headPortraitsUpdateTaskWithParams:(NSDictionary *)params{
    [JWHTTPRequest post:KHOME_MEMBERE_UPDATEUSERHEAD args:params target:self succ:^(NSString *responseString) {
        [self headPortraitsUpdateTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
}

-(void)headPortraitsUpdateTaskResponse:(NSString *)responseString{
    
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        
        self.returnBlock(responseModel);
    }
    }
}

/*更新医生信息*/
-(NSMutableDictionary *)updateUserInfoRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    return params;
    
}

-(void)updateUserInfoTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KHOME_MEMBERE_UPDATEDOCTORINFO args:params target:self succ:^(NSString *responseString) {
        [self updateUserInfoTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
}

-(void)updateUserInfoTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        
        self.returnBlock(responseModel);
    }
    }
}

/*获取医生信息*/
-(NSMutableDictionary *)getUserInfoRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    return params;
    
}

-(void)getUserInfoTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KHOME_MEMBERE_GETDOCTORINFO args:params target:self succ:^(NSString *responseString) {
        [self getUserInfoTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
}

-(void)getUserInfoTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        MyHomeModel *model =[MyHomeModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
    }
    }
}


/*获取标签*/
-(NSMutableDictionary *)getTagsRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:@"doctor_best" forKey:@"type"];
    return params;
}

-(void)getTagsTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KHOME_MEMBERE_GETTAGS args:params target:self succ:^(NSString *responseString) {
        [self getTagsTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];

}

-(void)getTagsTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        MyTagsModel *model = [MyTagsModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
    }}
}

/*获取银行列表*/
-(NSMutableDictionary *)getBankListRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    return params;
}

-(void)getBankListTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KHOME_MEMBERE_GETBANKLIST args:params target:self succ:^(NSString *responseString) {
        [self getBankListTaskTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
}

-(void)getBankListTaskTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
        if ([self isCorrectResponse:responseModel]) {
       
        MyBankModel *model = [MyBankModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
        }}
}

/*获取科室*/
-(NSMutableDictionary *)getDepartmentListRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    return params;
}

-(void)getDepartmentListTaskWithUrl:(NSString *)url Params:(NSDictionary *)params
{
    [JWHTTPRequest post:url args:params target:self succ:^(NSString *responseString) {
        [self getDepartmentListTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)getDepartmentListTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        MyDepartmentModel *model = [MyDepartmentModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
    }
    }
}

/*设置银行卡*/
-(NSMutableDictionary *)setBankCardRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version realname:(NSString *)realname bankNo:(NSString *)bankNo  bankName:(NSString *)bankName bank_id:(NSString *)bank_id
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:realname forKey:@"realname"];
    [params setObject:bankNo forKey:@"bankNo"];
    [params setObject:bankName forKey:@"bankName"];
    [params setObject:bank_id forKey:@"bank_id"];
    return params;
}

-(void)setBankCardTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KHOME_MEMBERE_SETBANKCARD args:params target:self succ:^(NSString *responseString) {
        [self setBankCardTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)setBankCardTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        self.returnBlock(responseModel);
    }}
}

/*获取账户信息*/
-(NSMutableDictionary *)getAccountInfoRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version {
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    return params;
}

-(void)getAccountInfoTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KHOME_MEMBERE_GETACCOUNRINFO args:params target:self succ:^(NSString *responseString) {
        [self getAccountInfoTaskTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];

}

-(void)getAccountInfoTaskTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        
        MyAccountInfoModel *model = [MyAccountInfoModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
    }}
}

/*获取账户信息*/
-(NSMutableDictionary *)getAccountRecoderRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version type:(NSString *)type page:(NSString *)page {
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:type forKey:@"type"];
    [params setObject:page forKey:@"page"];

    return params;
}

-(void)getAccountRecoderTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KHOME_MEMBERE_GETACCOUNRRECODER args:params target:self succ:^(NSString *responseString) {
        [self getAccountRecoderTaskTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
    
}

-(void)getAccountRecoderTaskTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        
        MyAccountRecoderModel *model = [MyAccountRecoderModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
      
    }}
}

/*意见反馈*/
-(NSMutableDictionary *)feedBackRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device version:(NSString *)version  content:(NSString *)content
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];

    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:content forKey:@"content"];
    
    return params;

}

-(void)feedBackTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KHOME_MEMBERE_FEEDBACK args:params target:self succ:^(NSString *responseString) {
        [self feedBackTaskTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];

}

-(void)feedBackTaskTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
        SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
        if ([self isCorrectResponse:responseModel]) {
            

            self.returnBlock(responseModel);
            
        }}
}

@end
