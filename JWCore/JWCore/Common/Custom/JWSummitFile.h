//
//  JWSummitFile.h
//  qinghaishiguang
//
//  Created by mac on 14-6-25.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JWHTTPRequestDelegate <NSObject>

@required

-(void)httpRequestResult:(NSDictionary *)result;

@end

@interface JWSummitFile : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (nonatomic,strong) id<JWHTTPRequestDelegate> delegate;

+(JWSummitFile *) shareInstance;

- (NSMutableURLRequest *)postRequestWithParems:(NSString *)url postParams:(NSMutableDictionary *)postParems  files:(NSDictionary *)files;

@end
