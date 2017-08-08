//
//  MylocationManager.m
//  JWCore
//
//  Created by 苟晓浪 on 2016/10/17.
//  Copyright © 2016年 WWJ. All rights reserved.
//
#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5
#import "MylocationManager.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@implementation MylocationManager
- (id)init
{
    self = [super init];
    if (self)
    {
        [self configLocationManager];    }
    
    return self;
}

+ (MylocationManager *)sharedInstance
{
    __strong static MylocationManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    //[self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
}

@end
