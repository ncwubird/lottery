//
//  MyApprovView.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyApprovView.h"

@implementation MyApprovView

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *homeViewXib = [[NSBundle mainBundle] loadNibNamed:@"MyApprovView" owner:self options:nil];
        self = [homeViewXib objectAtIndex:0];
        [self setFrame:frame];
        //[[[SysParams sharedInstance]logonModel]homeModel]
        self.nameLabel.text = [NSString stringWithFormat:@"姓名:%@",[[[[SysParams sharedInstance]logonModel]homeModel]realname]];
        self.typeLabel.text = [NSString stringWithFormat:@"执业类别:%@",[[[[SysParams sharedInstance]logonModel]homeModel]jobtitle]];
        self.doctorRangLabel.text = [NSString stringWithFormat:@"执业范围:%@",[[[[SysParams sharedInstance]logonModel]homeModel]department_type]];
   }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
