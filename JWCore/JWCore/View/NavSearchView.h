//
//  NavSearchView.h
//  JWCore
//
//  Created by JayWong on 16/9/7.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavSearchViewDelegate <NSObject>

-(void)didClickSearchBtn;

@end

@interface NavSearchView : UIView
@property id<NavSearchViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)searchAction:(id)sender;

@end
