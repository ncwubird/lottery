//
//  MyHomeModel.h
//  JWCore
//
//  Created by JayWong on 2016/9/23.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Service;
@interface MyHomeModel : NSObject

@property (nonatomic, copy) NSString *subscriber_identity;

@property (nonatomic, copy) NSString *department_type;
@property (nonatomic, copy) NSString *hospital_name;
@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *area_name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *jobtitle;
@property (nonatomic, copy) NSString *practitioners_date;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *qualification_certificate;
@property (nonatomic, copy) NSString *practice_certificate;
@property (nonatomic, copy) NSString *is_verify;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *service_identity;
@property (nonatomic, copy) NSString *service_info;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *verify_msg;
@property (nonatomic, copy) NSString *disabled;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *verify_text;
@property (nonatomic, copy) NSString *em_name;
@property (nonatomic, copy) NSString *em_pwd;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *isbindmobile;
@property (nonatomic, copy) NSString *isbindwechat;

@property (nonatomic, strong) NSArray<Service *> *service;



@end
@interface Service : NSObject

@property (nonatomic, copy) NSString *identity;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *month_num;

@property (nonatomic, copy) NSString *gift_month_num;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *sell_price;


@end

