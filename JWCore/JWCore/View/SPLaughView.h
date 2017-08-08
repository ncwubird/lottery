//
//  SPLaughView.h
//  Stepper
//
//  Created by WangWenjie on 15/10/8.
//  Copyright © 2015年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLaughView : UIView<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;

@property (weak, nonatomic) IBOutlet UIButton *seeBtn;
- (IBAction)oneNextAction:(id)sender;
- (IBAction)twoNextAction:(id)sender;
- (IBAction)gotoSee:(UIButton *)sender;



@property (weak, nonatomic) IBOutlet UILabel *pageOneFirstLbl;
@property (weak, nonatomic) IBOutlet UILabel *pageOneSecondLbl;
@property (weak, nonatomic) IBOutlet UILabel *pageOneThreeLbl;
@property (weak, nonatomic) IBOutlet UILabel *pageTwoFirstLbl;
@property (weak, nonatomic) IBOutlet UILabel *pageTwoSecondLbl;
@property (weak, nonatomic) IBOutlet UILabel *pageTwoThreeLbl;
@property (weak, nonatomic) IBOutlet UILabel *pageThreeFirstLbl;
@property (weak, nonatomic) IBOutlet UILabel *pageThreeSecondLbl;



@end
