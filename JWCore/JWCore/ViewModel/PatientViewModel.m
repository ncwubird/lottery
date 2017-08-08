
//
//  PatientViewModel.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/14.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "PatientViewModel.h"
#import "PatientHomeModel.h"
#import "PatientBaseDetailModel.h"
#import "PatientMedicalRecoderModel.h"
#import "PatientMedicalDetailModel.h"

@implementation PatientViewModel

/*获取患者列表*/
-(NSMutableDictionary *)getPatientListRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version page:(NSString *)page
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:page forKey:@"page"];
    return params;
}

-(void)getPatientListTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KUSER_PATIENT_LIST args:params target:self succ:^(NSString *responseString) {
        [self getPatientListTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
}

-(void)getPatientListTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
        
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        PatientHomeModel *model =[ PatientHomeModel mj_objectWithKeyValues:responseModel.info];
            self.returnBlock(model);
    }
}
}

/*获取单个用户病历记录*/
-(NSMutableDictionary *)getIndividualPatientMedicalRecordsRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version page:(NSString *)page uid:(NSString *)uid page_size:(NSString *)page_size

{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:page forKey:@"page"];
    [params setObject:page_size forKey:@"page_size"];
     [params setObject:uid forKey:@"uid"];

    return params;
}

-(void)getIndividualPatientMedicalRecordsTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KUSER_PATIENT_RECODER args:params target:self succ:^(NSString *responseString) {
        [self getIndividualPatientMedicalRecordsTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
}

-(void)getIndividualPatientMedicalRecordsTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        PatientMedicalRecoderModel *model = [PatientMedicalRecoderModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
    }}
}

/*获取单个用户病历详情*/
-(NSMutableDictionary *)getIndividualPatientMedicalDetailRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version mid:(NSString *)mid
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:mid forKey:@"mid"];

    return params;
}

-(void)getIndividualPatientMedicalDetailTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KUSER_PATIENT_DETAIL args:params target:self succ:^(NSString *responseString) {
        [self getIndividualPatientMedicalDetailTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
}

-(void)getIndividualPatientMedicalDetailTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
   if ([self codeResponse:firstResponseModel]) {
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([self isCorrectResponse:responseModel]) {
        PatientMedicalDetailModel *model = [PatientMedicalDetailModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
    }
   }
}

/*获取单个患者基本信息*/
-(NSMutableDictionary *)getIndividualPatientBaseDetailRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version  uid:(NSString *)uid

{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:token forKey:@"token"];
    [params setObject:device forKey:@"device"];
    [params setObject:version forKey:@"version"];
    [params setObject:uid forKey:@"uid"];
    
    return params;
}

-(void)getIndividualPatientBaseDetailTaskWithParams:(NSDictionary *)params
{
    [JWHTTPRequest post:KUSER_PATIENT_BASEDETAIL args:params target:self succ:^(NSString *responseString) {
        [self getIndividualPatientBaseDetailTaskResponse:responseString];
    } error:^(NSError *error) {
        [self taskError:error.description];
    }];
}

-(void)getIndividualPatientBaseDetailTaskResponse:(NSString *)responseString{
    NSLog(@"%@",responseString);
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:responseString];
    if ([self codeResponse:firstResponseModel]) {
    
        SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
        if ([self isCorrectResponse:responseModel]) {
        PatientBaseDetailModel *model =[PatientBaseDetailModel mj_objectWithKeyValues:responseModel.info];
        self.returnBlock(model);
    }}
}

@end
