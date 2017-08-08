//
//  MyHomeModel.m
//  JWCore
//
//  Created by JayWong on 2016/9/23.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyHomeModel.h"

@implementation MyHomeModel

+ (NSDictionary *)objectClassInArray{
    return @{@"service" : [Service class]};
}

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.subscriber_identity = [coder decodeObjectForKey:@"subscriber_identity"];
        self.department_type = [coder decodeObjectForKey:@"department_type"];
        self.hospital_name = [coder decodeObjectForKey:@"hospital_name"];
        self.province_name=[coder decodeObjectForKey:@"province_name"];
        self.city_name=[coder decodeObjectForKey:@"city_name"];
        self.area_name=[coder decodeObjectForKey:@"area_name"];
        self.address=[coder decodeObjectForKey:@"address"];
        self.longitude = [coder decodeObjectForKey:@"longitude"];
        self.latitude=[coder decodeObjectForKey:@"latitude"];
        self.realname=[coder decodeObjectForKey:@"realname"];
        self.jobtitle=[coder decodeObjectForKey:@"jobtitle"];
        self.verify_text=[coder decodeObjectForKey:@"verify_text"];
        self.nickname = [coder decodeObjectForKey:@"nickname"];
        self.verify_msg = [coder decodeObjectForKey:@"verify_msg"];

        self.practitioners_date=[coder decodeObjectForKey:@"practitioners_date"];
        self.tags=[coder decodeObjectForKey:@"tags"];
        self.summary=[coder decodeObjectForKey:@"summary"];
                
        self.service_identity=[coder decodeObjectForKey:@"service_identity"];
        self.service_info = [coder decodeObjectForKey:@"service_info"];
        
        self.qualification_certificate=[coder decodeObjectForKey:@"qualification_certificate"];
        self.practice_certificate=[coder decodeObjectForKey:@"practice_certificate"];
        self.is_verify=[coder decodeObjectForKey:@"is_verify"];
        self.pay_type = [coder decodeObjectForKey:@"pay_type"];
        self.avatar = [coder decodeObjectForKey:@"avatar"];
        self.disabled=[coder decodeObjectForKey:@"disabled"];
        self.mobile=[coder decodeObjectForKey:@"mobile"];
        self.user_id=[coder decodeObjectForKey:@"user_id"];
        self.service = [coder decodeObjectForKey:@"service"];
        self.em_name=[coder decodeObjectForKey:@"em_name"];
        self.em_pwd = [coder decodeObjectForKey:@"em_pwd"];
        self.link = [coder decodeObjectForKey:@"link"];
        self.isbindmobile = [coder decodeObjectForKey:@"isbindmobile"];
        self.isbindwechat = [coder decodeObjectForKey:@"isbindwechat"];

 }
    return self;
}


- (void) encodeWithCoder: (NSCoder *)coder
{   [coder encodeObject:self.department_type forKey:@"department_type"];
    [coder encodeObject:self.hospital_name forKey:@"hospital_name"];
    [coder encodeObject:self.province_name forKey:@"province_name"];
    [coder encodeObject:self.city_name forKey:@"city_name"];
    [coder encodeObject:self.area_name forKey:@"area_name"];
    [coder encodeObject:self.verify_text forKey:@"verify_text"];
    [coder encodeObject:self.nickname forKey:@"nickname"];
    [coder encodeObject:self.avatar forKey:@"avatar"];
    [coder encodeObject:self.verify_msg forKey:@"verify_msg"];


    [coder encodeObject:self.address forKey:@"address"];
    [coder encodeObject:self.longitude forKey:@"longitude"];
    [coder encodeObject:self.latitude forKey:@"latitude"];
    [coder encodeObject:self.realname forKey:@"realname"];
    [coder encodeObject:self.jobtitle forKey:@"jobtitle"];
    [coder encodeObject:self.practitioners_date forKey:@"practitioners_date"];
    [coder encodeObject:self.tags forKey:@"tags"];
    
    [coder encodeObject:self.summary forKey:@"summary"];
    [coder encodeObject:self.service_identity forKey:@"service_identity"];
    [coder encodeObject:self.service_info forKey:@"service_info"];
    [coder encodeObject:self.qualification_certificate forKey:@"qualification_certificate"];
    [coder encodeObject:self.practice_certificate forKey:@"practice_certificate"];
    [coder encodeObject:self.is_verify forKey:@"is_verify"];
    [coder encodeObject:self.pay_type forKey:@"pay_type"];
    
    [coder encodeObject:self.disabled forKey:@"disabled"];
    [coder encodeObject:self.mobile forKey:@"mobile"];
    [coder encodeObject:self.user_id forKey:@"user_id"];
    [coder encodeObject:self.service forKey:@"service"];
    [coder encodeObject:self.em_name forKey:@"em_name"];
    [coder encodeObject:self.em_pwd forKey:@"em_pwd"];
    [coder encodeObject:self.link forKey:@"link"];
    [coder encodeObject:self.isbindmobile forKey:@"isbindmobile"];
    [coder encodeObject:self.isbindwechat forKey:@"isbindwechat"];
    

    
}

@end
@implementation Service

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.identity = [coder decodeObjectForKey:@"identity"];
        self.type=[coder decodeObjectForKey:@"type"];
        self.title=[coder decodeObjectForKey:@"title"];
        self.month_num=[coder decodeObjectForKey:@"month_num"];
        self.gift_month_num=[coder decodeObjectForKey:@"gift_month_num"];
        self.price=[coder decodeObjectForKey:@"price"];
        self.sell_price=[coder decodeObjectForKey:@"sell_price"];

    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.identity forKey:@"identity"];
    [coder encodeObject:self.type forKey:@"type"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.month_num forKey:@"month_num"];
    [coder encodeObject:self.gift_month_num forKey:@"gift_month_num"];
    [coder encodeObject:self.price forKey:@"price"];
    [coder encodeObject:self.sell_price forKey:@"sell_price"];
}

@end
