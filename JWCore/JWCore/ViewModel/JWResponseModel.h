//
//  JWResponseModel.h
//  StepMoney
//
//  Created by JayWong on 16/4/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

//接口数据参数宏
#define STATUS @"status"
#define STATUS_REQUEST [NSNumber numberWithInteger:200]
#define STATUS_REQUEST_SUCCESS [NSNumber numberWithInteger:0]
#define STATUS_REQUEST_LIST_NO_DATA [NSNumber numberWithInteger:1]
#define STATUS_INVALID_REQUEST [NSNumber numberWithInteger:400]
#define STATUS_SERVER_ERROR [NSNumber numberWithInteger:500]
#define STATUS_INVALID_TOKEN [NSNumber numberWithInteger:401]
#define STATUS_INVALID_MINTOKEN [NSNumber numberWithInteger:399]
#define STATUS_INVALID_MAXTOKEN [NSNumber numberWithInteger:411]
#import <Foundation/Foundation.h>

@class Data,AppDelegateDependencies;
@interface JWResponseModel : NSObject

@property (nonatomic,retain) NSString * msg;

@property (nonatomic,retain) NSNumber * ret;

@property (nonatomic,retain) Data * data;

@property (nonatomic, strong) AppDelegateDependencies *dependencies;

/**
 *  网络异常
 */
+(void)taskExceptionError:(NSString *)string;

/**
 *  返回数据判断及处理
 */
-(BOOL)isCorrectResponse;

@end

@interface Data : NSObject

@property (nonatomic, copy) NSNumber *code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *jsonstr;  //仅用于图片上传接口

@property (nonatomic, strong) id info;

@end
