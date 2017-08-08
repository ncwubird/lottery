//
//  UIView+Snapshot.h
//  JWCore
//
//  Created by JayWong on 16/5/30.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Snapshot)

/**
 *  uiview按frame截图
 */
- (UIImage *)screenshot;

/**
 *  UIScrollView按contentsize截图
 */
- (UIImage *) screenshotOfContent:(UIScrollView *)scrollview;

@end
