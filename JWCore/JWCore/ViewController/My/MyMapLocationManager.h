//
//  MyMapLocationManager.h
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/17.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface MyMapLocationManager : NSObject
@property (nonatomic, strong) AMapLocationManager *locationManager;
+ (MyMapLocationManager *)sharedInstance;
@end
