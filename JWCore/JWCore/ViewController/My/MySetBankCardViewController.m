//
//  MySetBankCardViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/26.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MySetBankCardViewController.h"
#import "MyViewModel.h"
#import "MyBankModel.h"
#import "JWPickerView.h"

@interface MySetBankCardViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *bankOwnerTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankCardTextfield;
@property (weak, nonatomic) IBOutlet UILabel *bankTypeLab;
@property (nonatomic,retain) NSMutableArray *bankArr;
@property (nonatomic,retain) NSMutableDictionary *bankDict;
@end

@implementation MySetBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"收款账号" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_SAVE];
    self.bankArr = [NSMutableArray array];
    self.bankDict =[NSMutableDictionary dictionary];
    [self setReturnKeyTypeAndDelegateForTextfield:self.bankOwnerTextField];
    [self setDelegateAndNumberKeyboardForTextfield:self.bankCardTextfield type:UIKeyboardTypeNumberPad];
}

#pragma mark -button Action
-(void)navBarAction_Save:(UIButton *)sender{
    if ([self check]) {
         [self setBankCardHttpRequest];
    }
}

- (IBAction)chooseBank:(id)sender {
    if (self.bankArr.count==0) {
         [self bankListHttpRequest];
    }
    else
    {
        [self bankPickView];
    }
}

-(void)bankPickView
{
    [JWPickerView shareInstance:self.bankArr  ctrl:self selectRow:0 block:^(UIViewController *ctrl, NSString *str) {
        self.bankTypeLab.text =str;
        }];
}

#pragma mark - bank request
-(void)bankListHttpRequest
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[MyBankModel class]]) {
            for (BankItems *items in [(MyBankModel *)returnValue items]) {
                [self.bankArr addObject:items.blankname];
                [self.bankDict setObject:items.identity forKey:items.blankname];
            }
            [self bankPickView];
        }
    } WithFailureBlock:^{
        
    }];
    
    NSMutableDictionary *params = [viewModel getBankListRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]];
    [viewModel getBankListTaskWithParams:params];
}

-(void)setBankCardHttpRequest
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            [JWProgressView showSuccessWithStatus:[(SPResponseModel *)returnValue msg]];
            [self performSelector:@selector(goBack) withObject:nil afterDelay:1.5];
        }
    } WithFailureBlock:^{
        
    }];
    
    NSMutableDictionary *params = [viewModel setBankCardRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion] realname:self.bankOwnerTextField.text bankNo:self.bankCardTextfield.text bankName:self.bankTypeLab.text bank_id:self.bankDict[self.bankTypeLab.text]];
    
    [viewModel setBankCardTaskWithParams:params];
}

-(void)goBack
{
    [self.delegate reloadBankInfo];
    [self pop:YES];
}


#pragma mark -check
-(BOOL)check{
    
    if ([self.bankOwnerTextField isEmptyValue]) {
        [JWProgressView showErrorWithStatus:@"请输入持卡人!"];
       return NO;
    }

    if ([self.bankTypeLab.text isEqualToString:@""]) {
        [JWProgressView showErrorWithStatus:@"请选择银行!"];
        return NO;
    }
    
    
    if ([self.bankCardTextfield isEmptyValue]) {
       [JWProgressView showErrorWithStatus:@"请输入银行卡号!"];
       return NO;
    }
    
    if (![JWRegex checkBankCardNumber:self.bankCardTextfield.text]) {
        [JWProgressView showErrorWithStatus:@"请输入正确的银行卡号!"];
        return NO;
    }
    return YES;
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

@end
