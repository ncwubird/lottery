//
//  BaseViewController.m
//  JWCore
//
//  Created by JayWong on 16/6/1.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "BaseViewController.h"
#import "UINavigationController+NavigationBar.h"

@interface BaseViewController ()<UITextFieldDelegate>

@end

@implementation BaseViewController

#pragma mark -life cycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[[self.navigationController viewControllers] objectAtIndex:0] isEqual:self]) {
        [SysFunctions showTabbar];
    }else{
        [SysFunctions hiddenTabbar];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[@"#F3F4F5" hexColor]];
    //[self setAutomaticallyAdjustsScrollViewInsets:NO];
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

/**
 *  创建导航栏按钮
 */
- (void)addNavBar:(NSString *)title leftBtn:(BAR_BTN_TYPE)leftBtnType rightBtn:(BAR_BTN_TYPE)rightBtnType{
    
   if ([title isEqualToString:@"nav_clear"]){
        [self.navigationController clearNavigationBar];
        [self.navigationController statusBarBackgroundWithColor:[UIColor clearColor]];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:56/255.0 green:56/255.0 blue:56/255.0 alpha:1.0],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18],NSFontAttributeName,nil]];
        [self.navigationItem setTitle:title];
        
        
        [self.navigationController statusBarBackgroundWithColor:[UIColor whiteColor]];
        [self.navigationController setupNavBarBackimage:[UIImage imageNamed:@"nav_bar_white.png"] lineImage:[UIImage imageNamed:@"nav_bar_line.png"]];
    }
    
    if (leftBtnType==BAR_BTN_NONE) {
        UIBarButtonItem * barBtn=[[UIBarButtonItem alloc] initWithCustomView:[[UIButton alloc] init]];
        self.navigationItem.leftBarButtonItem=barBtn;
    }else if (leftBtnType==BAR_BTN_BACK) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 30, 30) imgName:@"back.png" action:@"Back"];
        self.navigationItem.leftBarButtonItem=barBtn;
        
    }else if (leftBtnType==BAR_BTN_BACK_WHITE) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, KNAV_H, KNAV_H) imgName:@"back_white.png" action:@"BackWhite"];
        self.navigationItem.leftBarButtonItem=barBtn;
        
    }else if (leftBtnType==BAR_BTN_BACK_TRACK) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 44, 44) imgName:@"GPS_3_1.png" action:@"Back"];
        self.navigationItem.leftBarButtonItem=barBtn;
        
    }else if (leftBtnType==BAR_BTN_MEMBER_CENTER){
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, KNAV_H, KNAV_H) imgName:@"" action:@"MemberCenter"];
        self.navigationItem.leftBarButtonItem=barBtn;
    }else if (leftBtnType==BAR_BTN_GPS){
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, KNAV_H, KNAV_H) imgName:@"nav_gps.png" action:@"GPS"];
        self.navigationItem.leftBarButtonItem=barBtn;
    }else if (leftBtnType==BAR_BTN_CLASSIFICATION){
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, KNAV_H, KNAV_H) imgName:@"nav_classification.png" action:@"Classification"];
        self.navigationItem.leftBarButtonItem=barBtn;
    }    
    if (rightBtnType==BAR_BTN_SHARE) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, KNAV_H, KNAV_H) imgName:@"" action:@"Share"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }else if (rightBtnType==BAR_BTN_MESSAGE) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, KNAV_H, KNAV_H) imgName:@"nav_message.png" action:@"Message"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }else if (rightBtnType==BAR_BTN_SHOPPING_CAR) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, KNAV_H, KNAV_H) imgName:@"nav_shoppingCar.png" action:@"ShoppingCar"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }else if (rightBtnType==BAR_BTN_DISCOVERY_FINISH){
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 44, 44) title:@"完成" action:@"DiscoveryFinish"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }else if (rightBtnType==BAR_BTN_MISSION_FINISH){
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 68, 44) title:@"完成记录" action:@"MissionFinish"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }else if (rightBtnType==BAR_BTN_SAVE_INFO){
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 44, 44) title:@"保存" action:@"SaveUserInfo"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }else if (rightBtnType==BAR_BTN_REWARD_DETAIL){
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 68, 44) title:@"收益明细" action:@"RewardDetail"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }else if (rightBtnType==BAR_BTN_WEB_CROSS) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, KNAV_H, KNAV_H) imgName:@"nav_cross.png" action:@"WebCross"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }else if (rightBtnType==BAR_BTN_INVITE_RECODER) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 68, 44) title:@"邀请记录" action:@"InviteRecoder"];
        self.navigationItem.rightBarButtonItem=barBtn;

    }else if (rightBtnType==BAR_BTN_TRACK_HISTORY) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 56, 44) imgName:@"GPS_3_2.png" action:@"TrackHistory"];
        [barBtn setTitle:@"历史记录"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }else if (rightBtnType==BAR_BTN_TRACK_SHARE) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 44, 44) imgName:@"GPS_3_14.png" action:@"TrackShare"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }
    else if (rightBtnType==BAR_BTN_SAVE) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 44, 44) title:@"保存" action:@"Save"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }
    else if (rightBtnType==BAR_BTN_COMMIT) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 44, 44) title:@"提交" action:@"Commit"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }
    else if (rightBtnType==BAR_BTN_MEDICALRECODER) {
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 44, 44) title:@"病历" action:@"MedicalRecoder"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }
    else if (rightBtnType==BAR_BTN_QRCODE){
        UIBarButtonItem * barBtn=[self barButtonWithFrame:CGRectMake(0, 0, 30, 30) imgName:@"qrcode.png" action:@"Qrcode"];
        self.navigationItem.rightBarButtonItem=barBtn;
    }

}


-(void)navBarAction_Back:(UIButton *)sender{
    [self pop:YES];
}

-(void)navBarAction_BackWhite:(UIButton *)sender{
    [self pop:YES];
}

-(void)navBarAction_WebCross:(UIButton *)sender{}

-(void)navBarAction_MemberCenter:(UIButton *)sender{}

-(void)navBarAction_Share:(UIButton *)sender{}

-(void)navBarAction_GPS:(UIButton *)sender{}
-(void)navBarAction_Qrcode:(UIButton *)sender{}
-(void)navBarAction_Message:(UIButton *)sender{}

-(void)navBarAction_Classification:(UIButton *)sender{}

-(void)navBarAction_ShoppingCar:(UIButton *)sender{}

-(void)navBarAction_DiscoveryFinish:(UIButton *)sender{}

-(void)navBarAction_MissionFinish:(UIButton *)sender{}

-(void)navBarAction_SaveUserInfo:(UIButton *)sender{}

-(void)navBarAction_RewardDetail:(UIButton *)sender{}

-(void)navBarAction_Search{}
-(void)navBarAction_InviteRecoder:(UIButton *)sender{
    [self push:@"MyInviteRecoderViewController" isNib:YES];

}

-(void)navBarAction_TrackHistory:(UIButton *)sender{}

-(void)navBarAction_TrackShare:(UIButton *)sender{}
-(void)navBarAction_Save:(UIButton *)sender{}
-(void)navBarAction_Commit:(UIButton *)sender{}
-(void)navBarAction_MedicalRecoder:(UIButton *)sender{}


-(UIBarButtonItem *)barButtonWithFrame:(CGRect)frame imgName:(NSString *)imgName action:(NSString *)action{
    SEL selctorAction=NSSelectorFromString([NSString stringWithFormat:@"navBarAction_%@:",action]);
    UIButton *barButton = [[UIButton alloc]initWithFrame:frame];
    barButton.backgroundColor = [UIColor clearColor];
    [barButton setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [barButton addTarget:self action:selctorAction forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:barButton];
}

-(UIBarButtonItem *)barButtonWithFrame:(CGRect)frame title:(NSString *)title action:(NSString *)action{
    SEL selctorAction=NSSelectorFromString([NSString stringWithFormat:@"navBarAction_%@:",action]);
    UIButton *barButton = [[UIButton alloc]initWithFrame:frame];
    barButton.backgroundColor = [UIColor clearColor];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor colorWithRed:56/255.0 green:56/255.0 blue:56/255.0 alpha:1.0] forState:UIControlStateNormal];
    [barButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [barButton addTarget:self action:selctorAction forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:barButton];
}


#pragma mark -NavSearchViewDelegate

-(void)didClickSearchBtn{
    [self navBarAction_Search];
}


#pragma mark -events response

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -UITextFieldDelegate-

-(void)setReturnKeyTypeAndDelegateForTextfield:(UITextField *)textField {
    [textField setDelegate:self];
    [textField setReturnKeyType:UIReturnKeyDone];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
}

-(void)setDelegateAndNumberKeyboardForTextfield:(UITextField *)textField type:(UIKeyboardType)type{
    [textField setDelegate:self];
    [textField setKeyboardType:type];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
       
        return NO;
    }
    return YES;
}

@end
