//
//  MySkillViewController.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#define gapX 20
#define gapY 10
#define columnH 25

#import "MySkillViewController.h"
#import "MyPersonalInformationViewController.h"
#import "MySkillCollectionViewCell.h"
#import "MySkillCollectionReusableView.h"
#import "MyViewModel.h"
#import "MyTagsModel.h"
@interface MySkillViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,assign)float titleWidth;
@property (nonatomic,strong)UICollectionView *bomttomcollectionView;

/** 全部热门活动 */
@property (nonatomic,strong)NSMutableArray *contentArr;

/** 添加的热门活动 */
@property (nonatomic,strong)NSMutableArray *addContenArr;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,retain)UILabel *topLabel;
@property (nonatomic,retain) UIView *tagView;
@property (nonatomic,retain) UIButton *lastButton;


@end

@implementation MySkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNavBar:@"擅长" leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_SAVE];
    [self setTopView];
    
    [self tagsHttpRequest];
}

-(void)navBarAction_Save:(UIButton *)sender
{
    [self updateTagsRequest];
}

#pragma mark -setSubview
-(void)setTopView
{
    MySkillCollectionReusableView *view = [[MySkillCollectionReusableView alloc]init];
    view.backgroundColor= [UIColor whiteColor];
    view.titlelab.text = @"我的";
    [view setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 48)];
    [self.view addSubview:view];
    _tagView = [[UIView alloc]initWithFrame:CGRectMake(0, 48, KSCREEN_WIDTH, 120)];
    _tagView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tagView];
    _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 53, KSCREEN_WIDTH, 25)];
    _topLabel.font = [UIFont systemFontOfSize:15.0];
    _topLabel.textColor =[UIColor lightGrayColor];
    _topLabel.textAlignment =NSTextAlignmentCenter;
    _topLabel.text =@"添加擅长项目,让用户找到更合适的你";
    [self.view addSubview:_topLabel];
    
}
-(void)setCollectView
{
    _addContenArr = [NSMutableArray array];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _bomttomcollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_tagView.frame), KSCREEN_WIDTH, KSCREEN_HEIGHT-CGRectGetMaxY(_tagView.frame)) collectionViewLayout:_flowLayout];
    
    _bomttomcollectionView.delegate = self;
    _bomttomcollectionView.dataSource = self;
    _flowLayout.minimumLineSpacing =10;
     _flowLayout.minimumInteritemSpacing =10;
    
    _bomttomcollectionView.backgroundColor = [UIColor whiteColor];
    
    [_bomttomcollectionView registerNib:[UINib nibWithNibName:@"CJBTagCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [_bomttomcollectionView registerNib:[UINib nibWithNibName:@"MySkillCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MySkillCollectionViewCell"];
    
    
    [_bomttomcollectionView registerNib:[UINib nibWithNibName:@"MySkillCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"topHeader"];
    
    [self.view addSubview:_bomttomcollectionView];
    
}

#pragma mark -add btn and reload
-(void)reloadTagView
{
    [_tagView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    _topLabel.hidden = _addContenArr.count>0?YES:NO;
    
    
    _lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lastButton.frame =CGRectMake(0, 15, 0, 5);
    
    for (int i =0; i<_addContenArr.count; i++) {
        CGSize size = [_addContenArr[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        if ((CGRectGetMaxX(_lastButton.frame)+size.width +6+gapX) < KSCREEN_WIDTH) {
            UIButton *columnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
          if (i ==0) {
                columnBtn.frame = CGRectMake(20, 15,size.width+6,columnH);

            }
           else
            {
             columnBtn.frame = CGRectMake(CGRectGetMaxX(_lastButton.frame)+gapX, CGRectGetMinY(_lastButton.frame),size.width+6,columnH);
            }
            columnBtn.tag = i;
            columnBtn.layer.cornerRadius = 4.f;
            columnBtn.layer.masksToBounds = YES;
            [columnBtn.layer setBorderWidth:1];
            [columnBtn.layer setBorderColor:[[UIColor colorWithRed:251/255.0 green:127 /255.0 blue:161/255.0 alpha:1.0] CGColor]];
            [columnBtn setTitle:_addContenArr[i] forState:UIControlStateNormal];
            [columnBtn setTitleColor:[UIColor colorWithRed:251/255.0 green:127 /255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
             columnBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            [columnBtn addTarget:self action:@selector(didClickColumnBtn:) forControlEvents:UIControlEventTouchUpInside];
           [_tagView addSubview:columnBtn];
            _lastButton = columnBtn;
            
        }
      else
      {
          if ((CGRectGetMaxY(_lastButton.frame)+30) >120)
      {
          [_tagView setH:CGRectGetMaxY(_lastButton.frame)+50];
          [_bomttomcollectionView setFrame:CGRectMake(0,CGRectGetMaxY(_tagView.frame), KSCREEN_WIDTH, KSCREEN_HEIGHT-CGRectGetMaxY(_tagView.frame))];
      }
         UIButton * columnBtn=[[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_lastButton.frame)+gapY,size.width+6,columnH)];
         columnBtn.tag = i;
          columnBtn.layer.cornerRadius = 4.f;
          columnBtn.layer.masksToBounds = YES;
          [columnBtn.layer setBorderWidth:1];
          [columnBtn.layer setBorderColor:[[UIColor colorWithRed:251/255.0 green:127 /255.0 blue:161/255.0 alpha:1.0] CGColor]];

         [columnBtn setTitle:_addContenArr[i] forState:UIControlStateNormal];
         columnBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
         [columnBtn setTitleColor:[UIColor colorWithRed:251/255.0 green:127 /255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
         [columnBtn addTarget:self action:@selector(didClickColumnBtn:) forControlEvents:UIControlEventTouchUpInside];
         [_tagView addSubview:columnBtn];
          _lastButton = columnBtn;

      }
    
    }
}

-(void)addVolumn
{
    _topLabel.hidden = _addContenArr.count>0?YES:NO;
    int num = _addContenArr.count -1;
    CGSize size = [_addContenArr[num] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    if ((CGRectGetMaxX(_lastButton.frame)+size.width +6+gapX) < KSCREEN_WIDTH ) {
        UIButton *columnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (num ==0) {
            columnBtn.frame = CGRectMake(20, 15,size.width+6,columnH);
            }
        else
        {
            columnBtn.frame = CGRectMake(CGRectGetMaxX(_lastButton.frame)+gapX, CGRectGetMinY(_lastButton.frame),size.width+6,columnH);
        }
        columnBtn.tag = num;
        columnBtn.layer.cornerRadius = 4.f;
        columnBtn.layer.masksToBounds = YES;
        [columnBtn.layer setBorderWidth:1];
        [columnBtn.layer setBorderColor:[[UIColor colorWithRed:251/255.0 green:127 /255.0 blue:161/255.0 alpha:1.0] CGColor]];


        [columnBtn setTitle:_addContenArr[num] forState:UIControlStateNormal];
       [columnBtn setTitleColor:[UIColor colorWithRed:251/255.0 green:127 /255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
        columnBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [columnBtn addTarget:self action:@selector(didClickColumnBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_tagView addSubview:columnBtn];
        _lastButton = columnBtn;
        
    }
    else
    {
        if ((CGRectGetMaxY(_lastButton.frame)+30) >120)
        {
            [_tagView setH:CGRectGetMaxY(_lastButton.frame)+50];
            [_bomttomcollectionView setFrame:CGRectMake(0,CGRectGetMaxY(_tagView.frame), KSCREEN_WIDTH, KSCREEN_HEIGHT-CGRectGetMaxY(_tagView.frame))];
        }
        UIButton * columnBtn=[[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_lastButton.frame)+gapY,size.width+6,columnH)];
        columnBtn.tag = num;
        columnBtn.layer.cornerRadius = 4.f;
        columnBtn.layer.masksToBounds = YES;
        [columnBtn.layer setBorderWidth:1];
        [columnBtn.layer setBorderColor:[[UIColor colorWithRed:251/255.0 green:127 /255.0 blue:161/255.0 alpha:1.0] CGColor]];

        [columnBtn setTitle:_addContenArr[num] forState:UIControlStateNormal];
        columnBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
       [columnBtn setTitleColor:[UIColor colorWithRed:251/255.0 green:127 /255.0 blue:161/255.0 alpha:1.0] forState:UIControlStateNormal];
        [columnBtn addTarget:self action:@selector(didClickColumnBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [_tagView addSubview:columnBtn];
        _lastButton = columnBtn;
        
    }
 
}

-(void)didClickColumnBtn:(UIButton *)sender{
    [_tagView bringSubviewToFront:sender];

    [_contentArr addObject:_addContenArr[sender.tag]];
    [_addContenArr removeObjectAtIndex:sender.tag];
    NSIndexPath *endIndexPath = [NSIndexPath indexPathForItem:_contentArr.count - 1 inSection:0];
    [self reloadTagView];
    [self.bomttomcollectionView insertItemsAtIndexPaths:@[endIndexPath]];

    /*NSIndexPath *endIndexPath1 = [NSIndexPath indexPathForItem:_contentArr.count - 2 inSection:0];
    UICollectionViewCell *selectCell = [_bomttomcollectionView cellForItemAtIndexPath:endIndexPath1];
    NSLog(@"%@",NSStringFromCGRect(selectCell.frame));
    CGRect cellConvertRect=[_bomttomcollectionView convertRect:selectCell.frame toView:self.view];
    NSLog(@"%@",NSStringFromCGRect(cellConvertRect));
    [UIView animateWithDuration:0.35 animations:^{
        [sender setFrame:cellConvertRect];
        [sender setAlpha:0];
    } completion:^(BOOL finished) {
        [sender removeFromSuperview];
        
     
    }];*/
}
#pragma mark -http request
-(void)tagsHttpRequest
{
   MyViewModel *viewModel =[MyViewModel new];
   [viewModel setBlockWithReturnBlock:^(id returnValue) {
    if ([returnValue isKindOfClass:[MyTagsModel class]]) {
        MyTagsModel *itemModel =returnValue;
        NSMutableArray *itemArr = [NSMutableArray array];
        for (int i =0;i <itemModel.items.count;i++) {
            TagsItems *items = itemModel.items[i];
            [itemArr addObject:items.content];
        }
        _contentArr = [NSMutableArray arrayWithArray:itemArr];
        [self setCollectView];
    }
     } WithFailureBlock:^{
    
    }];

    NSMutableDictionary *params = [viewModel getTagsRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]];
    [viewModel getTagsTaskWithParams:params];
}

#pragma mark -collection delegate and datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
  return self.contentArr.count;
   
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MySkillCollectionViewCell *tagcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MySkillCollectionViewCell" forIndexPath:indexPath];
    
    tagcell.layer.cornerRadius = 4.f;
    tagcell.layer.masksToBounds = YES;
    
    tagcell.titlelab.text = _contentArr[indexPath.row];
    tagcell.titlelab.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0];
    tagcell.titlelab.textAlignment = NSTextAlignmentCenter;
        return tagcell;
}

/**
 每个cell 的大小，随着字体大小改变width
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        _size = [_contentArr[indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    //NSLog(@"%f",_size.width);
    if (_size.width <160) {
        _size.width =150;
    }
        return CGSizeMake(_size.width,25);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  
    return UIEdgeInsetsMake(20, 5, 15, 5);
   
}

/**
 collectionView头尺寸
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.frame.size.width, 48);
}

/**
 collection的每个section的头视图
 */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
            MySkillCollectionReusableView *topColl = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"topHeader" forIndexPath:indexPath];
            topColl.titlelab.text = @"标签选择";
            //topColl.frame = CGRectZero;
            topColl.backgroundColor = [UIColor clearColor];
            return topColl;
        
    }
    
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * selectCell=[collectionView  cellForItemAtIndexPath:indexPath];
     CGRect cellConvertRect=[collectionView convertRect:selectCell.frame toView:self.view];
    [self.addContenArr addObject:[self.contentArr objectAtIndex:indexPath.row]];
    [self.contentArr removeObjectAtIndex:indexPath.row];
    [self.bomttomcollectionView deleteItemsAtIndexPaths:@[indexPath]];

    CGSize size = [_addContenArr.lastObject sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    UIButton *columnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    columnBtn.frame =CGRectMake(cellConvertRect.origin.x, cellConvertRect.origin.y, size.width+6, 25);
    [columnBtn setBackgroundColor:[UIColor whiteColor]];
    [columnBtn setTitle:_addContenArr.lastObject forState:UIControlStateNormal];
    [columnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [columnBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [columnBtn setAlpha:0.0];
    [self.view addSubview:columnBtn];

    [UIView animateWithDuration:0.35 animations:^{
        [columnBtn setAlpha:1.0];
        [columnBtn setFrame:[self caculateRect]];
    } completion:^(BOOL finished) {
        [columnBtn removeFromSuperview];
        //
        [self addVolumn];
    }];


}
-(CGRect)caculateRect
{   CGRect rect;
    int num = _addContenArr.count -1;
    CGSize size = [_addContenArr[num] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    if ((CGRectGetMaxX(_lastButton.frame)+size.width +6) < KSCREEN_WIDTH) {
        if (num ==0) {
            rect = CGRectMake(20, CGRectGetMinY(_lastButton.frame)+44+26,size.width+6,columnH);
        }
        else
        {
            rect = CGRectMake(CGRectGetMaxX(_lastButton.frame)+gapX, CGRectGetMinY(_lastButton.frame)+44,size.width+6,columnH);
        }
    }
        else
        {
            if ((CGRectGetMaxY(_lastButton.frame)+30) >120)
            {
                [_tagView setH:CGRectGetMaxY(_lastButton.frame)+50];
                [_bomttomcollectionView setFrame:CGRectMake(0,CGRectGetMaxY(_tagView.frame), KSCREEN_WIDTH, KSCREEN_HEIGHT-CGRectGetMaxY(_tagView.frame))];
            }
            rect=CGRectMake(20, CGRectGetMaxY(_lastButton.frame)+gapY+44+26,size.width+6,columnH);
    }
    return rect;
}

#pragma mark -update request
-(void)updateTagsRequest
{
    MyViewModel *viewModel =[MyViewModel new];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isKindOfClass:[SPResponseModel class]]) {
            [JWProgressView showSuccessWithStatus:[(SPResponseModel *)returnValue msg]];
        [self performSelector:@selector(goBack) withObject:nil afterDelay:1.5];
        }
    } WithFailureBlock:^{
        
    }];
    
    NSMutableDictionary *params = [viewModel updateUserInfoRequestURLWithUser_id:[SysParams getUserID] token:[SysParams getToken] device:@"iOS" version:[SysFunctions appVersion]];
    NSString *tagString = [_addContenArr componentsJoinedByString:@";"];
    [params setObject:tagString forKey:@"tags"];
    
    [viewModel updateUserInfoTaskWithParams:params];
}

-(void)goBack
{   
    [[[[SysParams sharedInstance] logonModel] homeModel] setTags:_contentArr];
    [SysParams saveLogonModel:[[SysParams sharedInstance] logonModel]];
   
    NSArray *viewC = [self.navigationController viewControllers];
    MyPersonalInformationViewController *vc = [viewC objectAtIndex:1];
    
    vc.skillLabel.text =[_addContenArr componentsJoinedByString:@";"];
    CGSize size = [vc.skillLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    vc.skillLabel.textAlignment = KSCREEN_WIDTH-90 -size.width >0?NSTextAlignmentRight:NSTextAlignmentLeft;
    [self.navigationController popToViewController:vc animated:YES];

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
