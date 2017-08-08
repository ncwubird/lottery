//
//  WebViewController.m
//  ETravel
//
//  Created by WangWenjie on 15/3/19.
//  Copyright (c) 2015年 WWJ. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController (){
    UIWebView *_web;
    
    NSURLConnection *_urlConnection;
    
    NSURLRequest *_request;
    
    BOOL _authenticated;
}

@end

@implementation WebViewController

#pragma mark -life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavBar:self.titleString leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_WEB_CROSS];
    [self loadWebView];
    
    //[self addProgressWithWebView:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)loadWebView{
    [self.webView setOpaque:NO];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setDelegate:self];
    [self.webView setScalesPageToFit:YES];
    
    NSRange range = [self.url rangeOfString:@"http"];
    if (range.location!=NSNotFound) {
        NSMutableURLRequest * quest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]]];
        [self.webView loadRequest:quest];
    }
    
}

#pragma mark -events response

-(void)navBarAction_Back:(UIButton *)sender{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self pop:YES];
    }
}

-(void)navBarAction_WebCross:(UIButton *)sender{
    [self pop:YES];
}

#pragma mark -UIWebViewDelegate-

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (!self.titleString) {
        [self addNavBar:[self webPageTitle] leftBtn:BAR_BTN_BACK rightBtn:BAR_BTN_NONE];
    }
}

- (NSString *)webPageTitle
{
    return [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
