//
//  MyMapLocationManager.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/17.
//  Copyright © 2016年 WWJ. All rights reserved.
//

#import "MyMapLocationManager.h"

@implementation MyMapLocationManager

- (id)init
{
    self = [super init];
    if (self)
    {self.locationManager = [[AMapLocationManager alloc] init];
        
        //[self.locationManager setDelegate:self];
        
        //设置期望定位精度
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        
        //设置不允许系统暂停定位
        [self.locationManager setPausesLocationUpdatesAutomatically:NO];
        
        //设置允许在后台定位
        [self.locationManager setAllowsBackgroundLocationUpdates:NO];
        
        //设置定位超时时间
        [self.locationManager setLocationTimeout:5];
        

    }
    
    
    return self;
}

+ (MyMapLocationManager *)sharedInstance
{
    __strong static MyMapLocationManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

@end
