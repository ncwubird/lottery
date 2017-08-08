//
//  WebViewController.h
//  Stepper
//
//  Created by WangWenjie on 15/9/21.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@property (retain,nonatomic) NSString * titleString;
@property (retain,nonatomic) NSString * url;

@end
