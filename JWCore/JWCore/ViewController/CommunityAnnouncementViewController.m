//
//  CommunityAnnouncementViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "CommunityAnnouncementViewController.h"
#import "CommunityAnnouncementCell.h"

@interface CommunityAnnouncementViewController ()<UITableViewDelegate,UITableViewDataSource,MJRefreshManagerDelegate>

@property (weak, nonatomic) IBOutlet JWTableView *listTable;


@end

@implementation CommunityAnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.rowHeight = 148;
    [_listTable registerNib:[UINib nibWithNibName:@"CommunityAnnouncementCell" bundle:nil] forCellReuseIdentifier:@"CommunityAnnouncementCell"];
    [[MJRefreshManager shareInstace] setDelegate:self];
    [MJRefreshManager addRefreshingHeaderAndFooter:_listTable];

}

- (void)viewWillAppear:(BOOL)animated
{
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
#pragma mark - tableview delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    //return _listTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityAnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityAnnouncementCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - mjrefresh delegate
-(void)loadNewData
{
    _listTable.CURRENT_PAGE = 1;
    [_listTable reloadData];
    //[self requestInfoTask];
    [_listTable endRefreshing];
}

-(void)loadMoreData
{
    _listTable.CURRENT_PAGE ++;
    //[self requestInfoTask];
}

@end
