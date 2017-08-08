//
//  MyAddressModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/11.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class City,Area;
@interface MyAddressModel : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *abb;
@property (nonatomic, copy) NSString *spell;
@property (nonatomic, copy) NSArray<City *> *city;

@end

@interface City : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *abb;
@property (nonatomic, copy) NSString *spell;
@property (nonatomic, copy) NSArray<Area *> *area;

@end

@interface Area : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *abb;
@property (nonatomic, copy) NSString *spell;

@end

