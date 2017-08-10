//
//  HomeViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "HomeViewController.h"
#import "DoubleBallViewController.h"

#import "HomeCell.h"

@interface HomeViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic,retain) DoubleBallViewController *doubleBallVC;//双色球
@property (nonatomic,retain) DoubleBallViewController *lotteryVC;//福彩3d
@property (nonatomic,retain) DoubleBallViewController *lottoVC;//大乐透
@property (nonatomic,retain) NSArray *vcArray;//子视图控制器数组
@property (nonatomic,retain) DoubleBallViewController *currentVc;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollv;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"大师预测" leftBtn:BAR_BTN_NONE rightBtn:BAR_BTN_NONE];
    [self setConfig];
    [self setSubViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - config

- (void)setConfig
{
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[@"#000000" hexColor],UITextAttributeTextColor,
                          [UIFont systemFontOfSize:15],
                          NSFontAttributeName,nil];
    
    [ self.segmentControl setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [self.segmentControl addTarget:self action:@selector(titleChoose:) forControlEvents:UIControlEventValueChanged];
    _mainScrollv.contentSize = CGSizeMake(KSCREEN_WIDTH *3, 0);
    _mainScrollv.delegate = self;
}

- (void)setSubViewController
{
    _doubleBallVC = [[DoubleBallViewController alloc]init];
    _lotteryVC = [[DoubleBallViewController alloc]init];
    _lottoVC = [[DoubleBallViewController alloc]init];
    _currentVc = _doubleBallVC;
    _vcArray = @[_doubleBallVC,_lotteryVC,_lottoVC];
    for (int i =0; i <3; i++) {
        DoubleBallViewController *VC =  _vcArray[i];
        VC.titleStr = [_segmentControl titleForSegmentAtIndex:_segmentControl.selectedSegmentIndex];
        [VC.view setFrame:CGRectMake( i *KSCREEN_WIDTH,0, self.mainScrollv.bounds.size.width, self.mainScrollv.bounds.size.height)];
        [self addChildViewController:VC];
        [self.mainScrollv addSubview:VC.view];
    }
}

#pragma mark - SegmentedControlSegment

- (void)titleChoose:(UISegmentedControlSegment *)sender
{
    _mainScrollv.contentOffset = CGPointMake(KSCREEN_WIDTH *_segmentControl.selectedSegmentIndex, 0);
}

#pragma mark - scrolDeleagte

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index =_mainScrollv.contentOffset.x/KSCREEN_WIDTH;
//    if (_currentVc == _vcArray[index]) return;
    NSLog(@"%d",index);
//    [self replaceController:_currentVc newController:_vcArray[index]];
    _segmentControl.selectedSegmentIndex = index;
}


@end
