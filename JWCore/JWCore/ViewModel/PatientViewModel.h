//
//  PatientViewModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/14.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "ViewModel.h"

@interface PatientViewModel : ViewModel

/*获取我的患者列表*/
-(NSMutableDictionary *)getPatientListRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version page:(NSString *)page;

-(void)getPatientListTaskWithParams:(NSDictionary *)params;

/*获取单个患者病历记录列表*/
-(NSMutableDictionary *)getIndividualPatientMedicalRecordsRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version page:(NSString *)page uid:(NSString *)uid page_size:(NSString *)page_size;

-(void)getIndividualPatientMedicalRecordsTaskWithParams:(NSDictionary *)params;

/*获取单个患者病历详情*/
-(NSMutableDictionary *)getIndividualPatientMedicalDetailRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version mid:(NSString *)mid;

-(void)getIndividualPatientMedicalDetailTaskWithParams:(NSDictionary *)params;

/*获取单个患者基本信息*/
-(NSMutableDictionary *)getIndividualPatientBaseDetailRequestURLWithUser_id:(NSString *)user_id token:(NSString *)token device:(NSString *)device  version:(NSString *)version uid:(NSString *)uid;

-(void)getIndividualPatientBaseDetailTaskWithParams:(NSDictionary *)params;




@end
