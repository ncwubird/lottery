//
//  PatientMedicalDetailrModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/14.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientMedicalDetailModel : NSObject

@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *visits_date;
@property (nonatomic, copy) NSString *subscriber_identity;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *doctor_name;
@property (nonatomic, copy) NSString *hospital_name;
@property (nonatomic, copy) NSString *complained_illness;
@property (nonatomic, copy) NSString *diagnostic_results;
@property (nonatomic, copy) NSString *submissive;
@property (nonatomic, copy) NSString *inspect_text;
@property (nonatomic, copy) NSString *inspect_image;
@property (nonatomic, copy) NSString *medication_info;


@end
