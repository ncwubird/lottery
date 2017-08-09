//
//  HomeHeadView.m
//  JWCore
//
//  Created by 苟晓浪 on 2017/8/9.
//  Copyright © 2017年 WWJ. All rights reserved.
//

#import "HomeHeadView.h"

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

@end
