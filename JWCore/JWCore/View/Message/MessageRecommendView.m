//
//  MessageRecommendView.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/8.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MessageRecommendView.h"

@implementation MessageRecommendView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *homeViewXib = [[NSBundle mainBundle] loadNibNamed:@"MessageRecommendView" owner:self options:nil];
        self = [homeViewXib objectAtIndex:0];
        [self setFrame:frame];
    }
    return self;
}

@end
