//
//  SPFirstResponseModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/29.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPFirstResponseModel : NSObject

@property (nonatomic, copy) NSNumber *ret;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSMutableDictionary *data;
@end
