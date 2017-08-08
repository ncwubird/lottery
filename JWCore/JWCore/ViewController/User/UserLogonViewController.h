//
//  UserLogonViewController.h
//  JWCore
//
//  Created by JayWong on 16/9/9.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "BaseViewController.h"

@interface UserLogonViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UITextField *accountTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)logonAction:(id)sender;
- (IBAction)registerAction:(id)sender;
- (IBAction)forgetPasswordAction:(id)sender;
@end
