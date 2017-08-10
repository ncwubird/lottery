//
//  JWItemsView.h
//  JWCore
//
//  Created by JayWong on 2016/9/24.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWItemsView : UIView

//@property (assign,nonatomic) NSInteger limitLine;

-(void)addItemsWithArray:(NSArray *)array width:(float)width;

+(float)itemsHeightWithArray:(NSArray *)array width:(float)width;

@property (nonatomic,copy) void(^cliclBlock)(NSString *type);
@end
