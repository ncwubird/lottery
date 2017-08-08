//
//  MySkillCollectionReusableView.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/9/27.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MySkillCollectionReusableView.h"


@implementation MySkillCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *homeViewXib = [[NSBundle mainBundle] loadNibNamed:@"MySkillCollectionReusableView" owner:self options:nil];
        self = [homeViewXib objectAtIndex:0];
        [self setFrame:frame];
                
}
    return self;
}

@end
