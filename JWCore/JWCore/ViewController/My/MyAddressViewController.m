//
//  MyAddressViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyAddressViewController.h"
#import "MyPersonalInformationViewController.h"
#import "JWAddressPickView.h"
#import "MyViewModel.h"
#import "MyMapLocationManager.h"
#import <AMapLocationKit/AMapLocationKit.h>
@interface MyAddressViewController ()<AMapLocationManagerDelegate>

@property (nonatomic,copy)NSMutableArray *addressArray;
@property (weak, nonatomic) IBOutlet UITextField *detailAreaTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *areaTextField;
@property (nonatomic,assign) float longitude;
@property (nonatomic,assign) float latitude;
@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"地址" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_SAVE];
    [self setReturnKeyTypeAndDelegateForTextfield:self.detailAreaTextField];
    [[[MyMapLocationManager sharedInstance] locationManager]setDelegate:self];
    [self locAction];
}


- (void)locAction
{
    //进行单次定位请求
   
       [[[MyMapLocationManager sharedInstance] locationManager]requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
           self.longitude  =location.coordinate.longitude;
           self.latitude  =location.coordinate.latitude;
           NSLog(@"%f-%f-%f",location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    }];
}


-(void)navBarAction_Save:(UIButton *)sender
{   if([self.areaTextField isEmptyValue]||[self.detailAreaTextField isEmptyValue])
   {
       [JWProgressView showErrorWithStatus:@"请填写完整地址!"];
       return;
   }
    if (!self.longitude||!self.latitude) {
        [self locAction];
    }
    if (!self.longitude||!self.latitude) {
        [JWProgressView showErrorWithStatus:@"提交失败,请重新提交"];
    }

    [self updateAddressRequest];
}

- (IBAction)areaChoose:(id)sender {
    [JWAddressPickView shareInstance:self block:^(UIViewController *ctrl, NSMutableArray *arr) {
        self.addressArray =[NSMutableArray arrayWithArray:arr];
        self.areaTextField.text = [arr componentsJoinedByString:@""];
    }];
}

#pragma mark -update namerequest
-(void)updateAddressRequest
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            
        [JWProgressView showSuccessWithStatus:[(SPResponseModel *)returnValue msg]];
        [self performSelector:@selector(goBack) withObject:nil afterDelay:1.5];
        }
    } WithFailureBlock:^{
       
    }];
    
    NSMutableDictionary *params = [viewModel updateUserInfoRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]];
    [params setObject:self.addressArray[0] forKey:@"province_name"];
    [params setObject:self.addressArray[1] forKey:@"city_name"];
    [params setObject:self.addressArray[2] forKey:@"area_name"];
    [params setObject:self.detailAreaTextField.text forKey:@"address"];
    [params setObject:[NSString stringWithFormat:@"%f",self.longitude] forKey:@"longitude"];
    [params setObject:[NSString stringWithFormat:@"%f",self.latitude] forKey:@"latitude"];

    [viewModel updateUserInfoTaskWithParams:params];
}

-(void)goBack
{
    [[[[SysParams sharedInstance] logonModel] homeModel] setProvince_name:[self.addressArray objectAtIndex:0]];
    [[[[SysParams sharedInstance] logonModel] homeModel] setCity_name:[self.addressArray objectAtIndex:1]];
    [[[[SysParams sharedInstance] logonModel] homeModel] setArea_name:[self.addressArray objectAtIndex:2]];
    [[[[SysParams sharedInstance] logonModel] homeModel] setAddress:self.detailAreaTextField.text];
    [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
    
   
    NSArray *viewC = [self.navigationController viewControllers];
    MyPersonalInformationViewController *vc = [viewC objectAtIndex:1];
    vc.addressLabel.text =[NSString stringWithFormat:@"%@%@%@%@",[self.addressArray objectAtIndex:0],[self.addressArray objectAtIndex:1],[self.addressArray objectAtIndex:2],self.detailAreaTextField.text];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@%@",[self.addressArray objectAtIndex:0],[self.addressArray objectAtIndex:1],[self.addressArray objectAtIndex:2],self.detailAreaTextField.text]);
    CGSize size = [vc.addressLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    vc.addressLabel.textAlignment = KSCREEN_WIDTH -90-size.width >0?NSTextAlignmentRight:NSTextAlignmentLeft;
    [self.navigationController popToViewController:vc animated:YES];

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
