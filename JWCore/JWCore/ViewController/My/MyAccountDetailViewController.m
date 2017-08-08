//
//  MyAccountDetailViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/26.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyAccountDetailViewController.h"
#import "MyAccountDetailCell.h"
#import "MyViewModel.h"
#import "MyAccountRecoderModel.h"
@interface MyAccountDetailViewController ()<UITableViewDelegate,UITableViewDataSource,MJRefreshManagerDelegate>
@property (nonatomic,copy) NSString *typeStr;
@property (weak, nonatomic) IBOutlet JWTableView *accountTable;
@property (nonatomic,retain)UIButton *currentBtn;
@property (nonatomic,retain) MyAccountRecoderModel *recoderModel;
@end

@implementation MyAccountDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"收支明细" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
    [self addTableConfigure];
    self.currentBtn = (UIButton *)[self.view viewWithTag:200];
    self.typeStr = @"in,out";
}

-(void)addTableConfigure
{
    [self.accountTable registerNib:[UINib nibWithNibName:@"MyAccountDetailCell" bundle:nil] forCellReuseIdentifier:@"MyAccountDetailCell"];
    self.accountTable.rowHeight = 66;
    self.accountTable.separatorStyle =UITableViewCellSeparatorStyleNone;
    [[MJRefreshManager shareInstace] setDelegate:self];
    [MJRefreshManager addRefreshingHeaderAndFooter:self.accountTable];
}

- (IBAction)queryRecoderAction:(id)sender {
    [self.currentBtn setTitleColor:[UIColor colorWithRed:116/255.0 green:116/255.0 blue:116/255.0 alpha:1.0] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.currentBtn =sender;
    self.typeStr = [self recodeType:sender];
    [self.accountTable.mj_header beginRefreshing];
}
#pragma mark - AccountRecoderHttpRequest
-(void)getAccountRecoderHttpRequest
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[MyAccountRecoderModel class]]) {
           
            self.recoderModel = (MyAccountRecoderModel *)returnValue;
            [self.accountTable resetTableData:self.recoderModel.items];
            [self.accountTable hiddenRefreshingFooterOrNot:self.recoderModel.page totalPage:self.recoderModel.page_count];
            [self.accountTable endRefreshing];
            [self.accountTable reloadData];
        
}   } WithFailureBlock:^{
        [self.accountTable endRefreshing];

    }];
    
    NSMutableDictionary *params = [viewModel getAccountRecoderRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion] type:self.typeStr page:[NSString stringWithFormat:@"%ld",(long)self.accountTable.CURRENT_PAGE]];
    
    [viewModel getAccountRecoderTaskWithParams:params];
}

-(NSString *)recodeType:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:
        {
            return @"in,out";
        }
            break;
            
        case 201:
        {
            return @"in";

        }
            break;
        case 202:
        {
            return @"out";
        }
            break;

        default:
            break;
    }
    return nil;
}

#pragma mark - tableview delegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.accountTable.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     MyAccountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAccountDetailCell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    RecoderItem *item = [self.accountTable.dataArray objectAtIndex:indexPath.row];
    cell.timeLabel.text =item.setup_date;
    cell.priceLabel.text =item.money;
    cell.detailLabel.text = item.desc;
    return cell;
    
}


#pragma mark -MJRefreshManagerDelegate

-(void)loadNewData{
    [self getAccountRecoderHttpRequest];
}

-(void)loadMoreData
{
     self.accountTable.CURRENT_PAGE ++;
      [self getAccountRecoderHttpRequest];
  
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
