//
//  MessageHomeViewController.m
//  JWCore
//
//  Created by JayWong on 2016/9/23.
//  Copyright © 2016年 WWJ. All rights reserved.
//
#import "ChatViewController.h"
#import "MessageHomeViewController.h"
#import "MessageRecommendView.h"
#import "MessageHomeCell.h"
#import "ChatViewController.h"
@interface MessageHomeViewController ()

@property (nonatomic,retain) MessageRecommendView *recommendView;
@property (weak, nonatomic) IBOutlet JWTableView *messageTable;
@end

@implementation MessageHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"消息" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_QRCODE];
    [self setSubview];
}

-(void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:YES];
    [self messageRecommendJudge];
    //[self.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -set subView
-(void)messageRecommendJudge
{
    if (self.messageTable.dataArray.count==0) {
        [self recommendView];
    }
    else
    {
        if (_recommendView) {
            [self.recommendView removeFromSuperview];
            
        }
    }
}

-(MessageRecommendView *)recommendView
{
    if (_recommendView==nil) {
        _recommendView = [[MessageRecommendView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        [_recommendView.recommondBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_recommendView];
    }
    return _recommendView;
}

-(void)click
{   self.tabBarController.tabBar.hidden =YES;
    ChatViewController *chatVC = [[ChatViewController alloc]initWithConversationChatter:@"easeuidemo2" conversationType:EMConversationTypeChat];
     chatVC.title = @"easeuidemo2";
    chatVC.tabBarController.tabBar.hidden =YES;
    self.tabBarController.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:chatVC animated:YES];
}

-(void)setSubview
{
    [self.messageTable registerNib:[UINib nibWithNibName:@"MessageHomeCell" bundle:nil] forCellReuseIdentifier:@"MessageHomeCell"];
    self.messageTable.rowHeight = 80;
    self.messageTable.separatorStyle =UITableViewCellSeparatorStyleNone;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -tableview delegate and datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.messageTable.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageHomeCell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{   if (editingStyle == UITableViewCellEditingStyleDelete) {
    // NSMutableArray *arr = [groupNumberArray objectAtIndex:indexPath.section];
    
    //[arr removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
