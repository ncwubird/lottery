//
//  UIView+Snapshot.m
//  JWCore
//
//  Created by JayWong on 16/5/30.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView(Snapshot)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIImage *)screenshot
{
    return [self screenshotForCroppingRect:self.bounds];
}

- (UIImage *)screenshotForCroppingRect:(CGRect)croppingRect
{
    UIGraphicsBeginImageContextWithOptions(croppingRect.size, NO, [UIScreen mainScreen].scale);
    // Create a graphics context and translate it the view we want to crop so
    // that even in grabbing (0,0), that origin point now represents the actual
    // cropping origin desired:
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL) return nil;
    CGContextTranslateCTM(context, -croppingRect.origin.x, -croppingRect.origin.y);
    
    [self layoutIfNeeded];
    [self.layer renderInContext:context];
    
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}

/**
 *  UIScrollView按contentsize截图
 */
- (UIImage *) screenshotOfContent:(UIScrollView *)scrollview
{
    if(scrollview.contentSize.height <= 0)
        return nil;
    
    UIImage* image = nil;
    
    UIGraphicsBeginImageContextWithOptions(scrollview.contentSize, NO, [UIScreen mainScreen].scale);
    {
        CGPoint savedContentOffset = scrollview.contentOffset;
        CGRect savedFrame = scrollview.frame;
        
        scrollview.contentOffset = CGPointZero;
        scrollview.frame = CGRectMake(0, 0, scrollview.contentSize.width, scrollview.contentSize.height);
        
        [scrollview.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollview.contentOffset = savedContentOffset;
        scrollview.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    return image;
}

@end
