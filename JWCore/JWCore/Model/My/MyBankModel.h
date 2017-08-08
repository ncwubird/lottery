//
//  MyBankModel.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/11.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BankItems;
@interface MyBankModel : NSObject

@property (nonatomic, copy) NSArray<BankItems *> *items;
@property (nonatomic, copy) NSString *msg;
@end

@interface BankItems : NSObject

@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *blankname;
@property (nonatomic, copy) NSString *log_image;
@property (nonatomic, copy) NSString *bankCode;
@end
