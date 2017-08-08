//
//  UITableView+Screenshot.m
//  Kiwi
//
//  Created by Marcin Stepnowski on 10/11/14.
//  Copyright (c) 2014 Marcin Stepnowski. All rights reserved.
//

#import "UIScrollView+DHSmartScreenshot.h"
#import "UIView+DHSmartScreenshot.h"

@implementation UIScrollView (DHSmartScreenshot)

-(UIImage*)screenshotOfVisibleContent{
    CGRect croppingRect = self.bounds;
    croppingRect.origin = self.contentOffset;
    return [self screenshotForCroppingRect: croppingRect];
}

- (UIImage *) screenshotOfContent
{
    if(self.contentSize.height <= 0)
        return nil;
    
    UIImage* image = nil;
    
    UIGraphicsBeginImageContextWithOptions(self.contentSize, NO, [UIScreen mainScreen].scale);
    {
        CGPoint savedContentOffset = self.contentOffset;
        CGRect savedFrame = self.frame;
        
        self.contentOffset = CGPointZero;
        self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
        
        [self.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        self.contentOffset = savedContentOffset;
        self.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    return image;
}


@end
