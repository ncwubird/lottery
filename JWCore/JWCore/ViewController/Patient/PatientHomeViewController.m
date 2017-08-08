//
//  PatientHomeViewController.m
//  JWCore
//
//  Created by JayWong on 2016/9/23.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "PatientHomeViewController.h"
#import "PatientHomeCell.h"
#import "PatientionNoneView.h"
#import "PatientViewModel.h"
#import "PatientHomeModel.h"
#import "PatientinfoModel.h"
#import "MyQRcodeView.h"
#import "ChatViewController.h"
#import "SCUserProfileEntity.h"

@interface PatientHomeViewController ()<UITableViewDelegate,UITableViewDataSource,MJRefreshManagerDelegate>
@property (weak, nonatomic) IBOutlet JWTableView *patientTable;
@property (nonatomic,retain)PatientionNoneView *noneView;
@property (nonatomic,retain)PatientHomeModel *homeModel;

@end

@implementation PatientHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"患者" leftBtn:BAR_BTN_NONE rightBtn:BAR_BTN_QRCODE];
    [self setSubview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutReload) name:KUSER_LOGIN_OUT object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{  [super viewWillAppear:animated];
   }
-(void)navBarAction_Qrcode:(UIButton *)sender{
    if ([[[[[SysParams sharedInstance]logonModel]homeModel] is_verify] isEqualToString:@"Y"]) {
        MyQRcodeView *view = [[MyQRcodeView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        [[SysFunctions keyWindow]addSubview:view];
    }
  
}

-(void)loginOutReload
{
    [self.patientTable.mj_header beginRefreshing];
}


#pragma mark -set subView

-(void)setSubview
{
    [self.patientTable registerNib:[UINib nibWithNibName:@"PatientHomeCell" bundle:nil] forCellReuseIdentifier:@"PatientHomeCell"];
    self.patientTable.rowHeight = 83;
    self.patientTable.separatorStyle =UITableViewCellSeparatorStyleNone;
    [[MJRefreshManager shareInstace] setDelegate:self];
    [MJRefreshManager addRefreshingHeaderAndFooter:self.patientTable];
}

-(void)patientNoJudge
{
    if (self.patientTable.dataArray.count==0) {
        [self.patientTable bringSubviewToFront:self.noneView];
        return;
    }
    else
    {
        if (_noneView) {
            [self.noneView removeFromSuperview];
        }
    }
}

-(PatientionNoneView *)noneView
{
    if (_noneView==nil) {
        _noneView = [[PatientionNoneView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        [self.patientTable addSubview:_noneView];
    }
    return _noneView;
}


#pragma mark - PatientListHttpRequest
-(void)getPatientListHttpRequest
{
    PatientViewModel *viewModel =[PatientViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[PatientHomeModel class]]) {
            
            self.homeModel =(PatientHomeModel *)returnValue;
            [self refreshJudge];
        }
    } WithFailureBlock:^{
        [self.patientTable endRefreshing];
        
    }];
    
    NSMutableDictionary *params = [viewModel getPatientListRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]  page:[NSString stringWithFormat:@"%ld",(long)self.patientTable.CURRENT_PAGE]];
    
    [viewModel getPatientListTaskWithParams:params];
}

-(void)refreshJudge
{
    [self.patientTable resetTableData:self.homeModel.items];
    
    [self.patientTable hiddenRefreshingFooterOrNot:self.homeModel.page totalPage:self.homeModel.page_count];
    [self.patientTable endRefreshing];
    [self.patientTable reloadData];
    [self patientNoJudge];
    for ( PatientRecoderItem *item  in  self.patientTable.dataArray) {
         PatientinfoModel *model = [PatientinfoModel mj_objectWithKeyValues:item.uinfo];
        if (![NSString isEmptyString:model.em_name]) {
            [SCUserProfileEntity saveUserProfileWithUsername:model.em_name forNickName:model.realname avatarURLPath:model.avatar];
        }
    }
}

#pragma mark - tableview delegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.patientTable.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientHomeCell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    PatientRecoderItem *item = [self.patientTable.dataArray objectAtIndex:indexPath.row];
    PatientinfoModel *model = [PatientinfoModel mj_objectWithKeyValues:item.uinfo];
    [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"my_headimage"]];
    cell.patientNamelabel.text =model.realname;
    cell.servelabel.text =item.status_text;
    if ( [cell.servelabel.text isEqualToString:@"服务中"]) {
        cell.servelabel.textColor = [UIColor colorWithRed:128/255.0 green:205/255.0 blue:103/255.0 alpha:1.0];
    }
    else
    {
         cell.servelabel.textColor = [UIColor colorWithRed:229/255.0 green:181/255.0 blue:44/255.0 alpha:1.0];
    }
    cell.timeLabel.text =item.service_date;
    [cell.detailBtn addTarget:self action:@selector(detailClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PatientRecoderItem *item = [self.patientTable.dataArray objectAtIndex:indexPath.row];
    PatientinfoModel *model = [PatientinfoModel mj_objectWithKeyValues:item.uinfo];
    ChatViewController *chatVc =[[ChatViewController alloc]initWithConversationChatter:model.em_name conversationType:EMConversationTypeChat];
    chatVc.title = model.realname;
    [self.navigationController pushViewController:chatVc animated:YES];
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{   if (editingStyle == UITableViewCellEditingStyleDelete) {
//       // NSMutableArray *arr = [groupNumberArray objectAtIndex:indexPath.section];
//    
//       //[arr removeObjectAtIndex:indexPath.row];
//    
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//   }
//}
//
//
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}

-(void)detailClick:(UIButton *)sender{
    PatientHomeCell *cell = (PatientHomeCell *)[[sender superview] superview];
    
    NSLog(@"%@",[[sender superview] superview]);
    NSIndexPath *indexPath = [self.patientTable indexPathForCell:cell];
    PatientRecoderItem *item = [self.patientTable.dataArray objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setObject:item.subscriber_identity forKey:K_UID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self push:@"PatientInformationViewController" isNib:YES];

}
#pragma mark - mjrefresh delegate
-(void)loadNewData
{
    [self getPatientListHttpRequest];
}

-(void)loadMoreData
{
    self.patientTable.CURRENT_PAGE ++;
    [self getPatientListHttpRequest];
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
