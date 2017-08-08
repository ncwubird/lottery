//
//  UITableView+Animation.m
//  JWCore
//
//  Created by JayWong on 16/7/30.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "UITableViewCell+Animation.h"

@implementation UITableViewCell(Animation)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)scaleAnimation{
    self.layer.transform = CATransform3DMakeScale(0.96, 0.96, 1);
        
    [UIView animateWithDuration:0.25 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

@end
