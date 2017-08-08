//
//  MySummitAuthenticationView.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MySummitAuthenticationView.h"
@implementation MySummitAuthenticationView

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *homeViewXib = [[NSBundle mainBundle] loadNibNamed:@"MySummitAuthenticationView" owner:self options:nil];
        self = [homeViewXib objectAtIndex:0];
        [self setFrame:frame];
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
