//
//  PatientInformationViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/28.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "PatientInformationViewController.h"

#import "PatientViewModel.h"
#import "PatientBaseDetailModel.h"
@interface PatientInformationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *medicalHistorylabel;
@property (weak, nonatomic) IBOutlet UILabel *operationHistorylabel;
@property (weak, nonatomic) IBOutlet UILabel *drugAllergyLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodHypersensitivityLabel;
@end

@implementation PatientInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self addNavBar:@"基本信息" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_MEDICALRECODER];
    [self getPatientBaseInfoHttpRequest];
}
-(void)navBarAction_MedicalRecoder:(UIButton *)sender{
  
     [self push:@"PatientMedicalRecordViewController" isNib:YES];
}

-(CGFloat)caculateTextWidth:(NSString *)text
{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    return size.width;
}

#pragma mark - PatientBaseInfoHttpRequest
-(void)getPatientBaseInfoHttpRequest
{
    __weak typeof(self) weakSelf = self;
    PatientViewModel *viewModel =[PatientViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [JWRequestExceptionAlertView hiddenRequestExceptionInController:weakSelf];

        if ([returnValue isKindOfClass:[PatientBaseDetailModel class]]) {
            PatientBaseDetailModel *model =(PatientBaseDetailModel *)returnValue;
            
            weakSelf.nameLabel.text =model.realname;
            
            weakSelf.medicalHistorylabel.text =model.family_disease;
           // weakSelf.medicalHistorylabel.textAlignment = KSCREEN_WIDTH -121-[self caculateTextWidth:model.family_disease] >0?NSTextAlignmentRight:NSTextAlignmentLeft;

            weakSelf.operationHistorylabel.text =model.operation_disease;
           // weakSelf.operationHistorylabel.textAlignment = KSCREEN_WIDTH -121-[self caculateTextWidth:model.operation_disease] >0?NSTextAlignmentRight:NSTextAlignmentLeft;
            weakSelf.drugAllergyLabel.text =model.medicine_allergy;
           // weakSelf.drugAllergyLabel.textAlignment = KSCREEN_WIDTH -121-[self caculateTextWidth:model.medicine_allergy] >0?NSTextAlignmentRight:NSTextAlignmentLeft;
            
            weakSelf.foodHypersensitivityLabel.text =model.food_allergy;
            //weakSelf.foodHypersensitivityLabel.textAlignment = KSCREEN_WIDTH -121-[self caculateTextWidth:model.food_allergy] >0?NSTextAlignmentRight:NSTextAlignmentLeft;
            
            }
     } WithFailureBlock:^{
        [JWRequestExceptionAlertView showRequestExceptionInController:weakSelf reloadBlcok:^{
            [weakSelf getPatientBaseInfoHttpRequest];
        }];

        
    }];
    
    NSMutableDictionary *params = [viewModel getIndividualPatientBaseDetailRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken]  device:@"iOS" version:[SysFunctions appVersion] uid:[[NSUserDefaults standardUserDefaults] objectForKey:K_UID]];
    [viewModel getIndividualPatientBaseDetailTaskWithParams:params];
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
