//
//  ViewModel.h
//  StepMoney
//
//  Created by JayWong on 16/4/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

//接口数据参数宏
#define STATUS @"status"
#define K_UID @"uid"
#define STATUS_SUCCESS_CODE [NSNumber numberWithInteger:0]
#define STATUS_TOKEN_INVALID [NSNumber numberWithInteger:401]

#import <Foundation/Foundation.h>
#import "SPResponseModel.h"
#import "SPFirstResponseModel.h"
#import "RequestAddress.h"

#import "NSObject+MJKeyValue.h"

@interface ViewModel : NSObject

@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;


/**
 *  获取网络的链接状态
 */
-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock;

/**
 *  传入交互的Block块
 */
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
               WithFailureBlock: (FailureBlock) failureBlock;

/**
 *  状态值是否正确
 */
-(BOOL)isSuccessStatusCode:(NSNumber *)code;

/**
 *  获取数据失败
 */
-(void)taskFail:(SPResponseModel *)model;

/**
 *  获取数据错误
 */
-(void)taskError:(NSString *)string;

/**
 *  错误(服务器或者网络异常)
 */
-(void)taskExceptionError:(NSString *)string;

/**
 *  返回数据判断及处理
 */
-(BOOL)isCorrectResponse:(SPResponseModel *)responseModel;

/**
 *  返回code判断及处理
 */
-(BOOL)codeResponse:(SPFirstResponseModel *)responseModel;
/**
 *  NSObject转json string
 */
-(NSString *)objectToJsonString:(id)object;

@end
