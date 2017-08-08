//
//  UserForgetPasswordViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/26.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "UserForgetPasswordViewController.h"
#import "UserViewModel.h"

@interface UserForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (assign,nonatomic) NSInteger seconds;
@property (retain,nonatomic) NSString * keyToken;

@end

@implementation UserForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self addNavBar:@"忘记密码" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
     [self setSubviews];
}

-(void)setSubviews{
    [self setDelegateAndNumberKeyboardForTextfield:self.phoneTextField type:UIKeyboardTypeNumberPad];
    [self setDelegateAndNumberKeyboardForTextfield:self.codeTextField type:UIKeyboardTypeNumberPad];
    [self setReturnKeyTypeAndDelegateForTextfield:self.passwordTextField];
    [self setReturnKeyTypeAndDelegateForTextfield:self.repeatPasswordTextField];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)gainTestCode:(id)sender {
    if (![self phoneCheck]) return;
     [self forgetPasswordCodeRequest];


}

- (IBAction)comepleteBtnAction:(id)sender {
    if (![self checkValue]) return;
    [self forgetPasswordRequest];
}

-(void)forgetPasswordCodeRequest{
    UserViewModel * viewModel=[UserViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            //self.keyToken=[[(SPResponseModel *)returnValue data] objectForKey:@"key_token"];
            self.seconds=60;
            [self countdown60Seconds];
        }
    } WithFailureBlock:^{
        
    }];
    
    NSDictionary * params=[viewModel forgetPasswordCodeRequestURLWithTo:self.phoneTextField.text device:@"ios" version:[SysFunctions appVersion]];
    [viewModel forgetPasswordCodeTaskWithParams:params];
}

-(void)forgetPasswordRequest{
    UserViewModel * viewModel=[UserViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            //[SysParams saveLogonModel:(UserModel *)returnValue];
            
            [JWProgressView showSuccessWithStatus:@"重置密码成功!"];
            [self performSelector:@selector(pop) withObject:nil afterDelay:1.5];
        }
    } WithFailureBlock:^{
        
    }];
    NSDictionary * params=[viewModel forgetPasswordRequestURLWithCode:self.codeTextField.text account:self.phoneTextField.text password:self.passwordTextField.text device:@"ios" version:[SysFunctions appVersion]];
    [viewModel forgetPasswordTaskWithParams:params];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -private
-(BOOL)checkValue{
    if ([self phoneCheck]==NO) return NO;
    
    if ([self.codeTextField isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请输入验证码!"];
        return NO;
    }
    
    if ([self.passwordTextField isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请输入密码!"];
        return NO;
    }
    
    if ([self.repeatPasswordTextField isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请重复新密码!"];
        return NO;
    }
    
    if (![self.repeatPasswordTextField isSameTextWith:self.passwordTextField]) {
        [JWProgressView showErrorWithStatus:@"两次输入的密码不一致!"];
        return NO;
    }
    
    return  YES;
}

-(void)countdown60Seconds{
    if (self.seconds<=0) {
        [self.codeBtn setEnabled:YES];
        [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        return;
    }else{
        [self.codeBtn setEnabled:NO];
    }
    
    //[self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld秒",(long)self.seconds] forState:UIControlStateNormal];
    self.seconds--;
    [self performSelector:_cmd withObject:nil afterDelay:1.0];
    
}

-(BOOL)phoneCheck{
    if ([self.phoneTextField isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请输入手机号码!"];
        return NO;
    }
    
    if (![JWRegex regexCellphoneNo:self.phoneTextField.text]) {
        [JWProgressView showErrorWithStatus:@"请输入正确手机号码!"];
        return NO;
    }
    return YES;
}

@end
