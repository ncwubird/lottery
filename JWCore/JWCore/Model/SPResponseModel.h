//
//  SPResponseModel.h
//  StepMoney
//
//  Created by JayWong on 16/4/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPResponseModel : NSObject

@property (nonatomic, copy) NSNumber *code;

@property (nonatomic, retain) NSMutableDictionary *info;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *msg;

@end
