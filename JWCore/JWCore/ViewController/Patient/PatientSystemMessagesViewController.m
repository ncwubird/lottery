//
//  PatientSystemMessagesViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/7.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "PatientSystemMessagesViewController.h"
#import "PatientSystemMessageCell.h"
#import "MessageViewModel.h"
#import "MessageSystemModel.h"
@interface PatientSystemMessagesViewController ()<MJRefreshManagerDelegate>
@property (weak, nonatomic) IBOutlet JWTableView *systemMessageTable;
@property (nonatomic,retain)MessageSystemModel *systemModel;


@end

@implementation PatientSystemMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"系统消息" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
    [self setSystemMessageTable];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)setSystemMessageTable
{
    [self.systemMessageTable registerNib:[UINib nibWithNibName:@"PatientSystemMessageCell" bundle:nil] forCellReuseIdentifier:@"PatientSystemMessageCell"];
    self.systemMessageTable.rowHeight = 80;
    self.systemMessageTable.separatorStyle =UITableViewCellSeparatorStyleNone;
    [[MJRefreshManager shareInstace] setDelegate:self];
    [MJRefreshManager addRefreshingHeaderAndFooter:self.systemMessageTable];

}

#pragma mark -tableview delegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.systemMessageTable.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientSystemMessageCell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    SystemItem *item =[self.systemMessageTable.dataArray objectAtIndex:indexPath.row];
    cell.detailLlabel.text =item.desc;
    cell.timeLabel.text = item.create_time;
    
    return cell;
    
}

#pragma mark - getSystemMessageHttpRequest
-(void)getSystemMessageHttpRequest
{
    MessageViewModel *viewModel =[MessageViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[MessageSystemModel class]]) {
            
            self.systemModel =(MessageSystemModel *)returnValue;
            [self refreshJudge];

        }
    } WithFailureBlock:^{
        [self.systemMessageTable endRefreshing];
    }];
    
    NSDictionary *params = [viewModel getSystemMessageRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion] ];
    
    [viewModel getSystemMessageTaskWithParams:params];
}

-(void)refreshJudge
{
    [self.systemMessageTable resetTableData:self.systemModel.items];
    
    [self.systemMessageTable endRefreshing];
    [self.systemMessageTable reloadData];
}

#pragma mark - mjrefresh delegate
-(void)loadNewData
{
    [self getSystemMessageHttpRequest];
}

-(void)loadMoreData
{
    self.systemMessageTable.CURRENT_PAGE ++;
    [self getSystemMessageHttpRequest];
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
