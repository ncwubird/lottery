//
//  HTTPRequest.h
//  VIPER-OC
//
//  Created by ddknows on 2016/11/30.
//  Copyright © 2016年 ddknows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModel.h"

@interface HTTPRequest :ViewModel

#pragma mark -user
/*登录*/
-(void)logonTaskWithAccount:(NSString *)account password:(NSString *)password;

@end
