//
//  MylocationManager.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/17.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <AMapLocationKit/AMapLocationKit.h>

@interface MylocationManager : AMapLocationManager

@property (nonatomic, strong) AMapLocationManager *locationManager;
+ (MylocationManager *)sharedInstance;


@end
