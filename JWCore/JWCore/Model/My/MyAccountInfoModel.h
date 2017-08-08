//
//  MyAccountInfoModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/13.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAccountInfoModel : NSObject

@property (nonatomic, retain)NSDictionary *bankcard;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *pay_money;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *disabled;
@property (nonatomic, copy) NSString *subscriber_identity;
@end



