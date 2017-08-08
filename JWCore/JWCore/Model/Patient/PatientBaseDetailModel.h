//
//  PatientBaseDetailModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/14.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientBaseDetailModel : NSObject

@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *family_disease;
@property (nonatomic, copy) NSString *family_disease_text;
@property (nonatomic, copy) NSString *self_disease;
@property (nonatomic, copy) NSString *self_disease_text;
@property (nonatomic, copy) NSString *operation_disease;
@property (nonatomic, copy) NSString *operation_disease_text;
@property (nonatomic, copy) NSString *medicine_allergy;
@property (nonatomic, copy) NSString *medicine_allergy_text;
@property (nonatomic, copy) NSString *food_allergy;
@property (nonatomic, copy) NSString *food_allergy_text;
@property (nonatomic, copy) NSString *dady_mobile;
@property (nonatomic, copy) NSString *disabled;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *age;
@end
