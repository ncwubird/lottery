//
//  HomeDetailViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/10.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "HomeDetailView.h"
#import "JWItemsView.h"
@interface HomeDetailViewController ()

@property (nonatomic,retain) HomeDetailView *detailView;
@property (nonatomic,retain) NSArray *unhiddenArray;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollv;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:[NSString stringWithFormat:@"%@-大师预测排行榜",self.titleStr] leftBtn:BAR_BTN_BACK_WHITE rightBtn:BAR_BTN_NONE];
    [_mainScrollv addSubview:self.detailView];
    _mainScrollv.contentSize = CGSizeMake(KSCREEN_WIDTH, _detailView.frame.size.height+100);
    _detailView.itemView.cliclBlock = ^(NSString *type) {
        NSLog(@"88888%@",type);
    };
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
- (HomeDetailView *)detailView
{
    if (!_detailView) {
        _detailView = [[HomeDetailView alloc]init];
        [_detailView.unhiddenArray removeObject:self.typeStr];
        CGFloat height = [JWItemsView itemsHeightWithArray:_detailView.unhiddenArray width:KSCREEN_WIDTH - 10];
        [_detailView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 313+height)];
        [_detailView setSubView];
    }
    return _detailView;
}


@end
