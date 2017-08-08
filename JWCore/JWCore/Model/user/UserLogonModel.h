//
//  UserLogonModel.h
//  JWCore
//
//  Created by JayWong on 16/9/9.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyHomeModel.h"
#import "MyAccountInfoModel.h"
@interface UserLogonModel : NSObject
@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSDictionary *uinfo;

@property (nonatomic, copy) NSString *url;
@property (nonatomic, retain) MyHomeModel *homeModel;
@property (nonatomic, retain) MyAccountInfoModel *accountModel;

@end

