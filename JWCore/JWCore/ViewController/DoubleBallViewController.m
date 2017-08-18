//
//  DoubleBallViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "DoubleBallViewController.h"
#import "HomeCell.h"
#import "HomeHeadView.h"
#import "HomeDetailViewController.h"

@interface DoubleBallViewController ()<UITableViewDelegate,UITableViewDataSource,HomeHeadViewDelegate>

@property (weak, nonatomic) IBOutlet JWTableView *listTable;
@property (nonatomic,retain) HomeHeadView *headView;
@end

@implementation DoubleBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.rowHeight = 75;
    [_listTable registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    _listTable.tableHeaderView = self.headView;
    [_headView setConfig];
    //[_listTable reloadData];
    [self getHospitalRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![[[self.navigationController viewControllers] objectAtIndex:0] isEqual:self]) {
        [SysFunctions showTabbar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    //return _listTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailViewController *vc =[[HomeDetailViewController alloc]init];
    vc.typeStr = _headView.unhiddenArray[_headView.index];
    vc.titleStr = self.titleStr;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter
 -(HomeHeadView *)headView
{
    if (!_headView) {
        _headView = [[HomeHeadView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 164)];
        _headView.delegate = self;
    }
    return _headView;
}

#pragma mark - HomeHeadViewDelegate
- (void)refreshHeadViewHeightWithHeight:(CGFloat)height
{
    [_headView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, height)];
    self.listTable.tableHeaderView = _headView;
    [self.listTable reloadData];
}


#pragma mark -request
-(void)getHospitalRequest
{
    HTTPRequest * viewModel=[HTTPRequest new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        JWResponseModel * responseModel=[JWResponseModel mj_objectWithKeyValues:returnValue];
        if ([responseModel isCorrectResponse]) {
            
            //[_listTable hiddenRefreshingFooterOrNot:self.findModel.page totalPage:self.findModel.page_count];
                
                }
    } WithFailureBlock:^(id error){
        [_listTable endRefreshing];
    }];
   // [viewModel getMyHospitalWithPage:[NSString stringWithFormat:@"%ld",(long)_hospitalTable.CURRENT_PAGE]];
}

@end
