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
@property (nonatomic,retain) DoubleBallViewController *doubleBallVC;
@property (nonatomic,retain) DoubleBallViewController *lotteryVC;
@property (nonatomic,retain) DoubleBallViewController *lottoVC;
@property (nonatomic,retain) NSArray *vcArray;;
@property (nonatomic,retain) DoubleBallViewController *currentVc;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollv;
@property (weak, nonatomic) IBOutlet JWTableView *listTable;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"大师预测" leftBtn:BAR_BTN_NONE rightBtn:BAR_BTN_NONE];
    [self setConfig];
    [self setScrollv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setConfig
{
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[@"#000000" hexColor],UITextAttributeTextColor,
                          [UIFont systemFontOfSize:15],
                          NSFontAttributeName,nil];
    
    [ self.segmentControl setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [self.segmentControl addTarget:self action:@selector(titleChoose:) forControlEvents:UIControlEventValueChanged];
}

- (void)setScrollv
{
    _mainScrollv.contentSize = CGSizeMake(KSCREEN_WIDTH *3, 0);
    _mainScrollv.delegate = self;
    _doubleBallVC = [[DoubleBallViewController alloc]init];
    _lotteryVC = [[DoubleBallViewController alloc]init];
    _lottoVC = [[DoubleBallViewController alloc]init];
    _currentVc = _doubleBallVC;
    _vcArray = @[_doubleBallVC,_lotteryVC,_lottoVC];
    for (int i =0; i <3; i++) {
        DoubleBallViewController *VC =  _vcArray[i];
        [VC.view setFrame:CGRectMake( i *KSCREEN_WIDTH,0, self.mainScrollv.bounds.size.width, self.mainScrollv.bounds.size.height)];
        [self addChildViewController:VC];
        [self.mainScrollv addSubview:VC.view];
        //[VC.view setFrame:CGRectMake( i *KSCREEN_WIDTH,0, KSCREEN_WIDTH,self.mainScrollv.bounds.size.height)];
        NSLog(@"%@",NSStringFromCGRect(VC.view.frame));
      
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
