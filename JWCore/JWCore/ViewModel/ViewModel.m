//
//  ViewModel.m
//  StepMoney
//
//  Created by JayWong on 16/4/19.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "ViewModel.h"
#import "JWHTTPRequest.h"

@implementation ViewModel

/**
 *  获取网络的链接状态
 */
-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock{
    BOOL netState = [JWHTTPRequest netWorkReachability];
    netConnectBlock(netState);
}

/**
 *  传入交互的Block块
 */
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _failureBlock = failureBlock;
}

@end
