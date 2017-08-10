//
//  JWItemsView.m
//  JWCore
//
//  Created by JayWong on 2016/9/24.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "JWItemsView.h"

@implementation JWItemsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addItemsWithArray:(NSArray *)array width:(float)width{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    
    float intervalWidth=8;
    float intervalHeight=10;
    
    float orginX=0;
    float orginY=0;
    NSInteger indexLine=0;
    for (NSString * name in array) {
        
        
        //CGSize nameSize=[name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],}];
        CGSize nameSize = CGSizeMake(66, 18);
        nameSize=CGSizeMake(nameSize.width+8, 28);
        
        UIButton * nameBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, nameSize.width, 28)];
        [nameBtn setTitle:name forState:UIControlStateNormal];
        //[nameLbl setTextAlignment:NSTextAlignmentCenter];
        nameBtn.titleLabel.font = [UIFont systemFontOfSize:14];
       // [nameLbl setFont:[UIFont systemFontOfSize:14]];
        [nameBtn setTitleColor:[@"#0e0e0e" hexColor] forState:UIControlStateNormal];
       // [nameLbl setTextColor:[@"#FC97B0" hexColor]];
        [nameBtn.layer setBorderColor:[[@"#e8e8e8" hexColor] CGColor]];
        [nameBtn.layer setBorderWidth:1.0];
        [nameBtn.layer setCornerRadius:5.0];
        nameBtn.layer.masksToBounds= YES;
        [nameBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        if (orginX+intervalWidth+nameBtn.frame.size.width>width) {
            orginX=0;
            [nameBtn setFrame:CGRectMake(0, orginY+28+intervalHeight, nameSize.width, 28)];
            indexLine++;
        }else{
            [nameBtn setFrame:CGRectMake(orginX, orginY, nameSize.width, 28)];
        }
        [self addSubview:nameBtn];
        
        orginX=orginX+intervalWidth+nameSize.width;
        orginY=nameBtn.frame.origin.y;
    }
    
    [self setH:orginY+28];
}

+(float)itemsHeightWithArray:(NSArray *)array width:(float)width{
    if (!array||[array count]==0) {
        return 0;
    }
    
    float intervalWidth=8;
    float intervalHeight=10;
    
    float orginX=0;
    float orginY=0;
    for (NSString * name in array) {
        CGSize nameSize=[name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],}];
        nameSize=CGSizeMake(nameSize.width+8, 28);
        
        if (orginX+intervalWidth+nameSize.width>width) {
            orginX=0;
            orginY=orginY+28+intervalHeight;
           
        }
        
        orginX=orginX+intervalWidth+nameSize.width;
    }
    
    return orginY+28;

}

- (void)itemClick:(UIButton *)sender
{
    NSLog(@"666");
    if(self.cliclBlock){
        self.cliclBlock(sender.titleLabel.text);
    }
}
@end
