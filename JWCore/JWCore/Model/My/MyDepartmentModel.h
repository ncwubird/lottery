//
//  MyDepartmentModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/12.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyItems;
@interface MyDepartmentModel : NSObject

@property (nonatomic, copy) NSArray<MyItems *> *items;
@property (nonatomic, copy) NSString *msg;

@end

@interface MyItems : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *code;

@end
