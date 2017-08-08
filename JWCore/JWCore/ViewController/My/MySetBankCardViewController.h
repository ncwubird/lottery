//
//  MySetBankCardViewController.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/26.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "BaseViewController.h"

@protocol BankDelegate <NSObject>

-(void)reloadBankInfo;

@end


;

@interface MySetBankCardViewController : BaseViewController

@property id<BankDelegate> delegate;
@end
