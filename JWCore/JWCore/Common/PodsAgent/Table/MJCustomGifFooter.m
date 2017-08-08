//
//  MJCustomGifFooter.m
//  ProgramDemo
//
//  Created by WangWenjie on 15/8/10.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import "MJCustomGifFooter.h"

@implementation MJCustomGifFooter

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=19; i++) {
        UIImage *image = [self FSCoreImageForName:[NSString stringWithFormat:@"home_%d",i] inDirectory:@"loadingMode/home"];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

- (UIImage *)FSCoreImageForName:(NSString *)imageName inDirectory:(NSString *)directory{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"FSCore" ofType:@"bundle"]; //显然这里你也可以通过其他的方式取得，总之找到bundle的完整路径即可。
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"%@", imageName] ofType:@"png" inDirectory:directory]];
}

@end
