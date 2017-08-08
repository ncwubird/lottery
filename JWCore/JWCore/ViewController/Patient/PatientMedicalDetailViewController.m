//
//  PatientMedicalDetailViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/28.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "PatientMedicalDetailViewController.h"
#import "PatientViewModel.h"
#import "PatientMedicalDetailModel.h"
#import "ClickImage.h"

@interface PatientMedicalDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *medicalTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;


@property (weak, nonatomic) IBOutlet UILabel *complainLabel;

@property (weak, nonatomic) IBOutlet UILabel *diagnoseLabel;

@property (weak, nonatomic) IBOutlet UILabel *doctorDeviceLabel;
@property (weak, nonatomic) IBOutlet UIView *bigView;

@property (weak, nonatomic) IBOutlet UILabel *prescribeLabel;
@property (nonatomic,retain)PatientMedicalDetailModel *detailModel;
@end

@implementation PatientMedicalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"患者" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
    [self getPatientMedicalDetailHttpRequest];
}

-(void)setDetailInfo
{
    self.medicalTimeLabel.text = self.detailModel.visits_date;
    self.departmentLabel.text =[NSString stringWithFormat:@"%@ %@",self.detailModel.department,self.detailModel.doctor_name];
    self.doctorDeviceLabel.text =self.detailModel.submissive;
    self.complainLabel.text = self.detailModel.complained_illness;
    self.diagnoseLabel.text =self.detailModel.diagnostic_results;
    self.prescribeLabel.text =self.detailModel.medication_info;
    NSArray *imageArr = [self.detailModel.inspect_image componentsSeparatedByString:@"|"];
    for (int i =0; i<imageArr.count; i++) {
    UIImageView *ibgView = [[UIImageView alloc]initWithFrame:CGRectMake(i *KSCREEN_WIDTH/imageArr.count, 3, KSCREEN_WIDTH/imageArr.count, self.bigView.frame.size.height-6)];
        [ibgView sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:nil];
        [ibgView canClickIt:YES];
        [self.bigView addSubview:ibgView];
    }
}

#pragma mark - getPatientMedicalDetail
-(void)getPatientMedicalDetailHttpRequest
{
    __weak typeof(self) weakSelf = self;
    PatientViewModel *viewModel =[PatientViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [JWRequestExceptionAlertView hiddenRequestExceptionInController:weakSelf];

        if ([returnValue isKindOfClass:[PatientMedicalDetailModel class]]) {
            weakSelf.detailModel =(PatientMedicalDetailModel *)returnValue;
            [weakSelf setDetailInfo];
            
                  }
    } WithFailureBlock:^{
        [JWRequestExceptionAlertView showRequestExceptionInController:weakSelf reloadBlcok:^{
            [weakSelf getPatientMedicalDetailHttpRequest];
        }];
 
        
    }];
    
    NSMutableDictionary *params = [viewModel getIndividualPatientMedicalDetailRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"ios" version:[SysFunctions appVersion] mid:self.rowStr];
    [viewModel getIndividualPatientMedicalDetailTaskWithParams:params];
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
