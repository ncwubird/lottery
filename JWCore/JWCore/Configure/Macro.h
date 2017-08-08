//
//  Macro.h
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/6.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#ifndef MVVMTest_Macro_h
#define MVVMTest_Macro_h

#define KNAV_H  21
#define KSCREEN_WIDTH           [[UIScreen mainScreen] bounds].size.width
#define KSCREEN_HEIGHT          [[UIScreen mainScreen] bounds].size.height

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);

#define FSLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define Fmt(fmt,...)        ([NSString stringWithFormat:fmt,##__VA_ARGS__])

//定义通知宏
#define KNOTIFICATION_APPLICATION_FOREGROUND_KEY @"notification_application_foreground_key"

//定义系统宏
#define KJPUSH_REMOTE_NOTIFICATION_DEVICE_TOKEN @"jpush_remote_notification_device_token"

#define KASSOCIATION_KEY @"ASSOCIATION_KEY"
#define KUSER_LOGIN_OUT @"USER_LOGIN_OUT"

#define KUSER_RELOAD_MESSAGE @"RELOAD_CONVERSATION_LIST"
#define KSHOW_GUIDE_VIEW @"SHOW_GUIDE_VIEW"

#define KUSER_INFORMATION @"USER_INFOMATION"

#define KUSER_LOGIN_INVALID @"USER_LOGIN_INVALID"
#define KENCRYPTION @"dabuxiangqianmall"

#define K_Token          @"bac358377f3eff2a7c3ee8f1bd9bd4f8"
#define KTABBAR_H  49
#define KTOPSTATE_H  20

//image
#define KPLACEHOLDER_IMAGE [UIImage imageNamed:@"placeholder_140*140.png"]

#define KPLACEHOLDER_IMAGE_HEADER [UIImage imageNamed:@"placeholder_200*200.png"]

#define KPLACEHOLDER_IMAGE_HOME [UIImage imageNamed:@"placeholder_200*160.png"]

#define KPLACEHOLDER_IMAGE_MALL_ADVERTISE [UIImage imageNamed:@"placeholder_750*240.png"]

#define KPLACEHOLDER_IMAGE_MALL_LIST [UIImage imageNamed:@"placeholder_750*160.png"]

#define KPLACEHOLDER_IMAGE_DISCOVERY_ADVERTISE [UIImage imageNamed:@"placeholder_750*300.png"]

#endif
