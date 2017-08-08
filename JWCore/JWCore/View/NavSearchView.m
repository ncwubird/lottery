//
//  NavSearchView.m
//  JWCore
//
//  Created by JayWong on 16/9/7.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "NavSearchView.h"

@implementation NavSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -life cycle

-(id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"NavSearchView" owner:self options:nil] lastObject];
        [self setFrame:frame];
    }
    return self;
}

#pragma mark -events response

- (IBAction)searchAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickSearchBtn)]) {
        [self.delegate didClickSearchBtn];
    }
}
@end
