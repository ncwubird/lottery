//
//  UITableView+EmptyData.h
//  JWCore
//
//  Created by JayWong on 16/6/2.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView(EmptyData)

- (void) tableViewDisplayWitMessage:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
