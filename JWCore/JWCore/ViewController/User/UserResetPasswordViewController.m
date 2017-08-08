//
//  UserResetPasswordViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/26.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "UserResetPasswordViewController.h"
#import "UserViewModel.h"

@interface UserResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *currentPasswordTf;

@property (weak, nonatomic) IBOutlet UITextField *changedPasswordTf;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTf;

@end

@implementation UserResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"修改密码" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_SAVE];
    
    [self setReturnKeyTypeAndDelegateForTextfield:self.currentPasswordTf];
    [self setReturnKeyTypeAndDelegateForTextfield:self.changedPasswordTf];
    [self setReturnKeyTypeAndDelegateForTextfield:self.surePasswordTf];
}
-(void)navBarAction_Save:(UIButton *)sender{
    
    if (![self checkValue]) return;
    [self changePasswordRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -request
-(void)changePasswordRequest{
    UserViewModel * viewModel=[UserViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
                       
            [JWProgressView showSuccessWithStatus:@"修改成功!"];
            [self performSelector:@selector(successReset) withObject:nil afterDelay:1.5];
        }
    } WithFailureBlock:^{
        
    }];
    NSLog(@"%@--%@",self.currentPasswordTf.text,self.changedPasswordTf.text);
    NSDictionary *params =[viewModel changePasswordURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"ios" version:[SysFunctions appVersion] oldpwd:self.currentPasswordTf.text password:self.changedPasswordTf.text];
    
    [viewModel changePasswordTaskWithParams:params];
}

#pragma mark - private

-(BOOL)checkValue{
    if ([self.currentPasswordTf isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请输入当前密码!"];
        return NO;
    }
    
    if ([self.changedPasswordTf isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请输入新密码!"];
        return NO;
    }
    
    if ([self.surePasswordTf isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请再次输入新密码!"];
        return NO;
    }
    
    if (![self.surePasswordTf isSameTextWith:self.changedPasswordTf]) {
        [JWProgressView showErrorWithStatus:@"两次输入的新密码不一致!"];
        return NO;
    }

    
    return YES;
}

-(void)successReset{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [SysFunctions presentLogonViewController];
}

@end
