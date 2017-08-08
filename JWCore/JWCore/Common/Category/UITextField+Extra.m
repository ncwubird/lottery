//
//  UITextField+Extra.m
//  VTCore
//
//  Created by mk on 13-10-4.
//  Copyright (c) 2013年 app1580.com. All rights reserved.
//

#import "UITextField+Extra.h"

@implementation UITextField (Extra)

- (void)addLeftPadding:(int)px
{
	UIView *tmp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, px, self.frame.size.height)];

	self.leftView		= tmp;
	self.leftViewMode	= UITextFieldViewModeAlways;
	tmp	= nil;
}

- (BOOL)isEmptyValue
{
	return self.text == nil || [self.text isEqualToString:@""] || [[self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}

- (BOOL)isSameTextWith:(UITextField *)other
{
	return [self.text isEqualToString:other.text];
}

@end
