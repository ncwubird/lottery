//
//  UserRegisterViewController.m
//  JWCore
//
//  Created by JayWong on 16/9/9.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "UserViewModel.h"
@interface UserRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;
@property (nonatomic,assign) BOOL protocolBtnState;

@property (assign,nonatomic) NSInteger seconds;
@property (retain,nonatomic) NSString * keyToken;
@end

@implementation UserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"注册" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
    [self setSubviews];
}

-(void)setSubviews{
   
    [self setDelegateAndNumberKeyboardForTextfield:self.phoneTextField type:UIKeyboardTypeNumberPad];
    [self setDelegateAndNumberKeyboardForTextfield:self.codeTextField type:UIKeyboardTypeNumberPad];
    [self setReturnKeyTypeAndDelegateForTextfield:self.passwordTextField];
    [self.protocolBtn setImage:[UIImage imageNamed:@"user_select"] forState:UIControlStateSelected];
    [self.protocolBtn addTarget:self action:@selector(protocolAgree) forControlEvents:UIControlEventTouchUpInside];
}

-(void)protocolAgree
{
    self.protocolBtn.selected =self.protocolBtnState;
    self.protocolBtnState=!self.protocolBtnState;
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

- (IBAction)codeAction:(id)sender{
    if (![self phoneCheck]) return;
    [self registerCodeRequest];
}

- (IBAction)registerAction:(id)sender{
    if (![self checkValue]) return;
    [self registerRequest];
}
- (IBAction)protolBtn:(id)sender {
    WebViewController *webController = [[WebViewController alloc]init];
    webController.url =KHOME_MEMBERE_PROROL;
    [self.navigationController pushViewController:webController animated:YES];
}

#pragma mark -request

-(void)registerCodeRequest{
    UserViewModel * viewModel=[UserViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
           // self.keyToken=[[(SPResponseModel *)returnValue data] objectForKey:@"key_token"];
            
            self.seconds=60;
            [self countdown60Seconds];
        }
    } WithFailureBlock:^{
        
    }];
    
    NSDictionary * params=[viewModel registerCodeRequestURLWithTo:self.phoneTextField.text version:[SysFunctions appVersion] device:@"ios"];
    [viewModel registerCodeTaskWithParams:params];
}

-(void)registerRequest{
    UserViewModel * viewModel=[UserViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            [JWProgressView showSuccessWithStatus:[(SPResponseModel *)returnValue msg]];
            [self performSelector:@selector(didRegister) withObject:nil afterDelay:1.5];
        }
    } WithFailureBlock:^{
        
    }];
    NSDictionary * params=[viewModel registerRequestURLWithCode:self.codeTextField.text device:@"ios" version:[SysFunctions appVersion] account:self.phoneTextField.text password:self.passwordTextField.text type:@"doctor"];
    [viewModel registerTaskWithParams:params];
}


#pragma mark -private

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
     if (!self.protocolBtn.selected)
     {
        [JWProgressView showErrorWithStatus:@"请同意爸爸知道用户端协议!"];
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
    
    [self.codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld秒",(long)self.seconds] forState:UIControlStateNormal];
    self.seconds--;
    [self performSelector:_cmd withObject:nil afterDelay:1.0];
    
}

-(void)didRegister{
    [self push:@"UserLogonViewController" isNib:YES];
}
@end
