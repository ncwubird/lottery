//
//  HomeHeadView.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "HomeHeadView.h"
#import "HomeCollectionCell.h"

@implementation HomeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *homeViewXib = [[NSBundle mainBundle] loadNibNamed:@"HomeHeadView" owner:self options:nil];
        self = [homeViewXib objectAtIndex:0];
        [self setFrame:frame];
        
    }
    return self;
}

- (void)setConfig
{
    _collect.delegate = self;
    _collect.dataSource = self;
    self.dataArray = self.hiddenArray;
    [_collect registerNib:[UINib nibWithNibName:@"HomeCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCollectionCell"];
    [_collect reloadData];
    _leadingConstraint.constant = (KSCREEN_WIDTH/2 -110)/2;
    //_collect.
}

- (IBAction)spelistChoose:(UIButton *)sender
{
    if (sender.selected) return;
    UIButton *btn = sender == _payButton?_freeButton:_payButton;
    sender.selected = !sender.selected;
    btn.selected = !btn.selected;
    _leadingConstraint.constant = sender.frame.origin.x+KSCREEN_WIDTH/4-55;
}


#pragma mark -CollectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionCell" forIndexPath:indexPath];
    [self setCellConfigWithIndexPath:indexPath cell:cell];
    return cell;
}

- (void)setCellConfigWithIndexPath:(NSIndexPath *)indexPath cell:(HomeCollectionCell *)cell
{
    if (indexPath.row == _dataArray.count - 2){
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName :[@"#ff0000" hexColor]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: self.dataArray[indexPath.row] attributes:attribtDic];
        cell.lineLabel.textColor = [@"#ff0000" hexColor];
        
        cell.lineLabel.attributedText = attribtStr;
        cell.titleLabel.hidden = YES;
    
    }else if (indexPath.row == _dataArray.count - 1){
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName :[@"#2583da" hexColor]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: self.dataArray[indexPath.row] attributes:attribtDic];
        cell.lineLabel.attributedText = attribtStr;
        cell.lineLabel.textColor = [@"#2583da" hexColor];
        cell.titleLabel.hidden = YES;
    }else{
         cell.titleLabel.text = self.dataArray[indexPath.row];
         cell.titleLabel.hidden = NO;
        if (indexPath.row == self.index)
        {
            cell.titleLabel.backgroundColor = [@"#ff0000" hexColor];
            cell.titleLabel.textColor = [UIColor whiteColor];
        }else{
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [@"#272727" hexColor];
        }
     }
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
   
    if ([cell.titleLabel.text isEqualToString:@"隐藏∧"]) {
        self.dataArray = self.hiddenArray;
        [self.delegate refreshHeadViewHeightWithHeight:164];
    }else if ([cell.titleLabel.text isEqualToString:@"更多∨"]){
        self.dataArray = self.unhiddenArray;
        [self.delegate refreshHeadViewHeightWithHeight:240];
    }else{
         self.index = indexPath.row;
    }
    [_collect reloadData];
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 8, 10, 8);//分别为上、左、下、右
}

#pragma mark -getter
- (NSArray *)unhiddenArray
{
    if (!_unhiddenArray) {
        _unhiddenArray = @[@"蓝球定三",@"红球独胆",@"蓝球定五",@"红球杀三",@"蓝球杀五",@"红球双胆",@"红球12码",@"红球杀六",@"红球三胆",@"红球25码",@"红球20码",@"隐藏∧",@"优惠套餐",@"指标说明"];
    }
    return _unhiddenArray;
}

- (NSArray *)hiddenArray
{
    if (!_hiddenArray) {
        _hiddenArray = @[@"蓝球定三",@"红球独胆",@"蓝球定五",@"红球杀三",@"蓝球杀五",@"更多∨",@"优惠套餐",@"指标说明"];
    }
    return _hiddenArray;
}

@end
