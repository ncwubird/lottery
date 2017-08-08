//
//  ViewModel.h
//  StepMoney
//
//  Created by JayWong on 16/4/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)(id error);
typedef void (^NetWorkBlock)(BOOL netConnetState);

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

@end
