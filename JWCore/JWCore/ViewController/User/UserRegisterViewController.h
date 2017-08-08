//
//  UserRegisterViewController.h
//  JWCore
//
//  Created by JayWong on 16/9/9.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "BaseViewController.h"

@interface UserRegisterViewController : BaseViewController
@property (nonatomic,assign) BOOL forgetPassword;

- (IBAction)codeAction:(id)sender;
- (IBAction)registerAction:(id)sender;

@end
