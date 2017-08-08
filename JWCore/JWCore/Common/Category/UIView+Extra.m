//
//  UIView+Extra.m
//  VTCore
//
//  Created by mk on 13-2-20.
//  Copyright (c) 2013年 app1580.com. All rights reserved.
//

#import "UIView+Extra.h"

@implementation UIView (Extra)

- (CGFloat)endY {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)endX {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)X {
    return self.frame.origin.x;
}
- (CGFloat)x {
    return self.X;
}

- (CGFloat)Y {
    return self.frame.origin.y;
}
- (CGFloat)y {
    return self.Y;
}

- (CGFloat)H {
    return self.frame.size.height;
}

- (CGFloat)h {
    return self.H;
}

- (CGFloat)W {
    return self.frame.size.width;
}

- (CGFloat)w {
    return self.W;
}


- (CGSize)size{
    CGRect frame = [self frame];
	return frame.size;
}

- (void)setW:(float)width
{
    CGRect frame = [self frame];
	frame.size.width = round(width);
	[self setFrame:frame];
}
- (void)setH:(float)height{
    CGRect frame = [self frame];
	frame.size.height = round(height);
	[self setFrame:frame];
}

- (void)setW:(float)width andH:(float)height
{
    [self setWH:CGSizeMake(width, height)];
}

- (void)setWH:(CGSize)size
{
    CGRect frame = [self frame];
	frame.size.width = round(size.width);
	frame.size.height = round(size.height);
	[self setFrame:frame];
    
}

- (void)addW:(float)width
{
    CGRect frame = [self frame];
	frame.size.width += width;
	[self setFrame:frame];
}

- (void)addH:(float)height
{
    CGRect frame = [self frame];
	frame.size.height += height;
	[self setFrame:frame];
}

- (void)addW:(float)width andH:(float)height
{
    CGRect frame = [self frame];
	frame.size.height += height;
    frame.size.width += width;
	[self setFrame:frame];
}

- (void)setX:(float)x
{
    [self setX:x andY:self.frame.origin.y];
}

- (void)setY:(float)y
{
    [self setX:self.frame.origin.x andY:y];
}

- (void)setX:(float)x andY:(float)y
{
    CGRect frame = [self frame];
	frame.origin.x = round(x);
	frame.origin.y = round(y);
	[self setFrame:frame];
}

- (void)setXY:(CGPoint)point
{
    [self setX:point.x andY:point.y];
}

- (void)setPositionCenteredOnPoint:(CGPoint)position{
    [self setX:(position.x - self.frame.size.width / 2) andY:(position.y - self.frame.size.height / 2)];
}

- (void)addX:(float)x
{
    CGRect frame = [self frame];
	frame.origin.x += x;
	[self setFrame:frame];
}
- (void)addY:(float)y{
    CGRect frame = [self frame];
	frame.origin.y += y;
	[self setFrame:frame];
}

- (void)addX:(float)x andY:(float)y
{
    CGRect frame = [self frame];
	frame.origin.y += y;
    frame.origin.x += x;
	[self setFrame:frame];
}

+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:CGRectMake(0, 0, lineLength, 2)];
    [shapeLayer setPosition:CGPointMake(lineLength / 2, 1)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:1];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineSpacing], [NSNumber numberWithInt:lineSpacing/2], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, lineLength, 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
