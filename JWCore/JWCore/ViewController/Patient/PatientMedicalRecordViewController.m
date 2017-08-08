//
//  PatientMedicalRecordViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/28.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "PatientMedicalRecordViewController.h"
#import "PatientMedicalRecoderCell.h"
#import "PatientNoRecoder.h"
#import "PatientMedicalRecoderModel.h"
#import "PatientViewModel.h"
#import "PatientMedicalDetailViewController.h"

@interface PatientMedicalRecordViewController ()<MJRefreshManagerDelegate>

@property (weak, nonatomic) IBOutlet JWTableView *medicalTable;
@property (nonatomic,retain) PatientNoRecoder * patientNoRecoderView;
@property (nonatomic,retain) PatientMedicalRecoderModel * recoderModel;
@end

@implementation PatientMedicalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self addNavBar:@"病历" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
    [self setMedicalTable];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)medicalRecoderNoJudge
{
    if (self.medicalTable.dataArray.count==0) {
        [self patientNoRecoderView];
    }
    else
    {
        if (_patientNoRecoderView) {
            [self.patientNoRecoderView removeFromSuperview];
            
        }
    }
}

-(PatientNoRecoder *)patientNoRecoderView
{
    if (_patientNoRecoderView==nil) {
        _patientNoRecoderView = [[PatientNoRecoder  alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        [self.view addSubview:_patientNoRecoderView];
    }
    return _patientNoRecoderView;
}


-(void)setMedicalTable
{
    [self.medicalTable registerNib:[UINib nibWithNibName:@"PatientMedicalRecoderCell" bundle:nil] forCellReuseIdentifier:@"PatientMedicalRecoderCell"];
    self.medicalTable.rowHeight = 83;
    self.medicalTable.separatorStyle =UITableViewCellSeparatorStyleNone;
    [[MJRefreshManager shareInstace] setDelegate:self];
    [MJRefreshManager addRefreshingHeaderAndFooter:self.medicalTable];
}

#pragma mark - PatientListHttpRequest
-(void)getPatientMedicalRecordsHttpRequest
{
    
    PatientViewModel *viewModel =[PatientViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if ([returnValue isKindOfClass:[PatientMedicalRecoderModel class]]) {
            self.recoderModel =(PatientMedicalRecoderModel *)returnValue;
            [self refreshJudge];
        }
    } WithFailureBlock:^{
        [self.medicalTable endRefreshing];
 
}];
    NSMutableDictionary *params=[viewModel getIndividualPatientMedicalRecordsRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"ios" version:[SysFunctions appVersion] page:[NSString stringWithFormat:@"%d",self.medicalTable.CURRENT_PAGE] uid:[[NSUserDefaults standardUserDefaults] objectForKey:K_UID] page_size:@"10"];
    
    [viewModel getIndividualPatientMedicalRecordsTaskWithParams:params];
}

-(void)refreshJudge
{
    [self.medicalTable endRefreshing];
    [self.medicalTable resetTableData:self.recoderModel.items];
    [self medicalRecoderNoJudge];
    [self.medicalTable hiddenRefreshingFooterOrNot:self.recoderModel.page totalPage:self.recoderModel.page_count];
   
    [self.medicalTable reloadData];
}

#pragma mark -tableview delegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.medicalTable.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientMedicalRecoderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientMedicalRecoderCell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    MedicalRecoderItem *item = [self.medicalTable.dataArray objectAtIndex:indexPath.row];
    cell.yearLabel.text =  [item.visits_date substringToIndex:4];
    cell.monthLabel.text =  [item.visits_date substringFromIndex:5];
    cell.medicalLabel.text =item.complained_illness;
    cell.hospitalLabel.text =item.hospital_name;
    cell.doctorLabel.text =[NSString stringWithFormat:@"%@ 医生",item.doctor_name];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   PatientMedicalDetailViewController *vc = [[PatientMedicalDetailViewController alloc]init];
    MedicalRecoderItem *item = [self.medicalTable.dataArray objectAtIndex:indexPath.row];
    vc.rowStr = [NSString stringWithFormat:@"%@",item.identity];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - mjrefresh delegate
-(void)loadNewData
{
    [self getPatientMedicalRecordsHttpRequest];
}

-(void)loadMoreData
{
    self.medicalTable.CURRENT_PAGE ++;
    [self getPatientMedicalRecordsHttpRequest];
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
