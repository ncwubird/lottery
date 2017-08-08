//
//  PatientMedicalRecoderModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/14.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MedicalRecoderItem;
@interface PatientMedicalRecoderModel : NSObject

@property (nonatomic, copy)NSArray<MedicalRecoderItem *> *items;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *page_count;

@end

@interface MedicalRecoderItem : NSObject

@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *visits_date;
@property (nonatomic, copy) NSString *doctor_name;
@property (nonatomic, copy) NSString *hospital_name;
@property (nonatomic, copy) NSString *complained_illness;

@end
