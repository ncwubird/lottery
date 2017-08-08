//
//  MyAuthenticationViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyAuthenticationViewController.h"
#import "MyApprovView.h"
#import "MyReviewView.h"
#import "MySummitAuthenticationView.h"
#import "JWImagePicker.h"
#import "JWSummitFile.h"
#import "MyViewModel.h"
#import "UserLogonModel.h"
@interface MyAuthenticationViewController ()<JWHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *stateImageview;
@property (weak, nonatomic) IBOutlet UILabel *summitLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *approvLabel;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (nonatomic,retain) UIView *stateView;
@property (nonatomic,retain) MySummitAuthenticationView *summitView;
@property (nonatomic,retain) NSMutableDictionary * urlDic;
@property (nonatomic,retain) NSMutableDictionary * imageDic;
@property (nonatomic,retain) UIImage *certificateImage;
@property (nonatomic,retain) UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UIView *msgView;

@end

@implementation MyAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imageDic=[NSMutableDictionary dictionary];
    self.urlDic=[NSMutableDictionary dictionary];
    [self setSubview];
}

-(void)navBarAction_Commit:(UIButton *)sender{
    
    if (!self.urlDic[@"left"]||!self.urlDic[@"right"]) {
        [JWProgressView showErrorWithStatus:@"请补充资格证书"];
        return;
    }
    [self certificateRequest];
}

-(void)setSubview
{
    NSString *verify=[[[[SysParams sharedInstance] logonModel]homeModel]is_verify];
    
    if ([verify isEqualToString:@"S"]) {
        [self addNavBar:@"医生认证" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_COMMIT];
        
        _summitView = [[MySummitAuthenticationView alloc]initWithFrame:CGRectMake(0, 76, KSCREEN_WIDTH, 190)];
        [_summitView.leftBtn addTarget:self action:@selector(imageChoose:) forControlEvents:UIControlEventTouchUpInside];
        [_summitView.rightBtn addTarget:self action:@selector(imageChoose:) forControlEvents:UIControlEventTouchUpInside];
        self.stateView =_summitView;
        [self.view addSubview:self.stateView];
        self.msgView .hidden =YES;
        self.summitLabel.textColor =[ UIColor blackColor];
        self.stateImageview.image =[UIImage imageNamed:@"my_submit"];
    }
    else if ([verify isEqualToString:@"W"])
    {
        [self addNavBar:@"医生认证" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
        MyReviewView *reviewView = [[MyReviewView alloc]initWithFrame:CGRectMake(0, 76, KSCREEN_WIDTH, 190)];
        self.stateView =reviewView;
        [self.view addSubview:self.stateView];
          self.reviewLabel.textColor =[ UIColor blackColor];
        self.stateImageview.image =[UIImage imageNamed:@"my_review"];
          self.msgView .hidden =YES;

    }
    else if ([verify isEqualToString:@"Y"])
    {
        [self addNavBar:@"医生认证" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
        MyApprovView *approvView = [[MyApprovView alloc]initWithFrame:CGRectMake(0, 76, KSCREEN_WIDTH, 190)];
        self.stateView =approvView;
        self.stateView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.stateView];
        self.approvLabel.textColor =[ UIColor blackColor];
        self.stateImageview.image =[UIImage imageNamed:@"my_approv"];
          self.msgView .hidden =YES;
        

    }
    else if ([verify isEqualToString:@"N"])
    {
        [self addNavBar:@"医生认证" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_COMMIT];
        _summitView = [[MySummitAuthenticationView alloc]initWithFrame:CGRectMake(0, 76, KSCREEN_WIDTH, 190)];
        [_summitView.leftBtn addTarget:self action:@selector(imageChoose:) forControlEvents:UIControlEventTouchUpInside];
        [_summitView.rightBtn addTarget:self action:@selector(imageChoose:) forControlEvents:UIControlEventTouchUpInside];
        self.stateView =_summitView;
        [self.view addSubview:self.stateView];
        self.stateImageview.image =[UIImage imageNamed:@"my_submit"];
        self.summitLabel.textColor =[ UIColor blackColor];
        self.msgView .hidden =NO;
        self.msgLabel.text = [[[[SysParams sharedInstance] logonModel]homeModel]verify_msg];
    }
}
-(void)imageChoose:(UIButton *)sender
{
    self.chooseBtn =sender;
   [JWImagePicker shareInstance:self title:@"选择证书" block:^(UIViewController *ctrl, UIImage *image) {
            self.certificateImage =image;
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
            [self.imageDic setObject:[NSData dataWithContentsOfFile:fullPath] forKeyedSubscript:@"file"];
            [self summitRequest];
    }];
}

#pragma mark -FSHTTPRequest
-(void)summitRequest
{
    NSMutableDictionary * params=[NSMutableDictionary dictionary];
    [params setObject:[SysParams getToken] forKey:@"token"];
    [params setObject:[SysParams getUserID] forKey:@"user_id"];
    [params setObject:@"device" forKey:@"ios"];
    [params setObject:[SysFunctions appVersion] forKey:@"version"];
    [[JWSummitFile shareInstance] setDelegate:self];
    [[JWSummitFile shareInstance] postRequestWithParems:[NSString stringWithFormat:@"%@%@",[SysFunctions getBaseURL],KHOME_IMAGE_UPLOAD] postParams:params files:([[self.imageDic allKeys] count]==0 ? nil : self.imageDic)];
    
}

#pragma mark -FSHTTPRequestDelegate
-(void)httpRequestResult:(NSDictionary *)result {
    
    ViewModel * viewModel=[ViewModel new];
    
    SPFirstResponseModel * firstResponseModel=[SPFirstResponseModel mj_objectWithKeyValues:result];
    SPResponseModel * responseModel=[SPResponseModel mj_objectWithKeyValues:firstResponseModel.data];
    if ([viewModel isCorrectResponse:responseModel]) {
        NSString *key =self.chooseBtn.tag ==1?@"left":@"right";
        UIImageView *ibg = self.chooseBtn.tag ==1?_summitView.leftImageView:_summitView.rightImageview;
        ibg.backgroundColor = [UIColor whiteColor];
        ibg.image = self.certificateImage;
        [self.urlDic setObject:responseModel.url forKey:key];
    }
}
#pragma mark -summit request
-(void)certificateRequest
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            
            [JWProgressView showSuccessWithStatus:[(SPResponseModel *)returnValue msg]];
            [self performSelector:@selector(updateUserLoginModel) withObject:nil afterDelay:1.5];
            
        }
    } WithFailureBlock:^{
        
    }];
    
    NSMutableDictionary *params = [viewModel updateUserInfoRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]];
    [params setObject:self.urlDic[@"left"] forKey:@"qr"];
    [params setObject:self.urlDic[@"right"] forKey:@"pc"];
    
    [viewModel updateUserInfoTaskWithParams:params];
}

#pragma mark -update userloginModel

-(void)updateUserLoginModel{
    [[[[SysParams sharedInstance] logonModel] homeModel] setQualification_certificate:self.imageDic[@"left"]];
    [[[[SysParams sharedInstance] logonModel] homeModel] setPractice_certificate:self.imageDic[@"right"]];
    [[[[SysParams sharedInstance] logonModel] homeModel] setIs_verify:@"W"];
    [[[[SysParams sharedInstance] logonModel] homeModel] setVerify_text:@"审核中"];
    [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
    [self pop:YES];
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
