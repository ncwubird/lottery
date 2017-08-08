//
//  PatientHomeModel.h
//  JWCore
//
//  Created by JayWong on 2016/9/23.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PatientRecoderItem,PatientInfo;
@interface PatientHomeModel : NSObject

@property (nonatomic, copy)NSArray<PatientRecoderItem *> *items;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, retain) NSString *page_count;
@end

@interface PatientRecoderItem : NSObject

@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *subscriber_identity;
@property (nonatomic, copy) NSString *doctor_identity;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *status_text;
@property (nonatomic, copy) NSString *service_date;
@property (nonatomic, copy) NSDictionary *uinfo;
@property (nonatomic, copy) NSDictionary *dinfo;

@end



