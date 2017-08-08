//
//  EGOImageLoadConnection.m
//  EGOImageLoading
//
//  Created by Shaun Harrison on 12/1/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "JWImageLoadConnection.h"


@implementation JWImageLoadConnection
@synthesize imageURL = _imageURL, response = _response, delegate = _delegate, timeoutInterval = _timeoutInterval;

#if __EGOIL_USE_BLOCKS
@synthesize handlers;
#endif

- (id)initWithImageURL:(NSURL *)aURL delegate:(id)delegate {
    if ((self = [super init])) {
        _imageURL = [aURL retain];
        self.delegate = delegate;
        _responseData = [[NSMutableData alloc] init];
        self.timeoutInterval = 10;

#if __EGOIL_USE_BLOCKS
		handlers = [[NSMutableDictionary alloc] init];
		#endif
    }

    return self;
}

- (void)start {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.imageURL
                                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                            timeoutInterval:self.timeoutInterval];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    [self startActivityIndicator];
    [request release];
}

- (void)cancel {
    [_connection cancel];
    [self stopActivityIndicator];
}

- (NSData *)responseData {
    return _responseData;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (connection != _connection) return;
    if ([self.delegate respondsToSelector:@selector(imageLoadConnection:didReceiveData:)]) {
        [self.delegate imageLoadConnection:connection didReceiveData:data];
    }
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (connection != _connection) return;
    self.response = response;
    if ([self.delegate respondsToSelector:@selector(imageLoadConnection:didReceiveResponse:)]) {
        [self.delegate imageLoadConnection:connection didReceiveResponse:response];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self stopActivityIndicator];
    if (connection != _connection) return;

    if ([self.delegate respondsToSelector:@selector(imageLoadConnectionDidFinishLoading:)]) {
        [self.delegate imageLoadConnectionDidFinishLoading:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self stopActivityIndicator];
    if (connection != _connection) return;

    if ([self.delegate respondsToSelector:@selector(imageLoadConnection:didFailWithError:)]) {
        [self.delegate imageLoadConnection:self didFailWithError:error];
    }
}

#pragma mark -创建菊花-

-(void)startActivityIndicator{
    UIView * aboveView=[[UIView alloc] initWithFrame:[[[[UIApplication sharedApplication] delegate] window] bounds]];
    [aboveView setTag:11];
    [aboveView setBackgroundColor:[UIColor clearColor]];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:aboveView];
    
    UIView * aboveActivity=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [aboveActivity setBackgroundColor:[UIColor blackColor]];
    [aboveActivity.layer setCornerRadius:5.0];
    [aboveActivity.layer setMasksToBounds:YES];
    [aboveActivity setCenter:aboveView.center];
    [aboveActivity setAlpha:0.4];
    [aboveView addSubview:aboveActivity];
    
    UIActivityIndicatorView * activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity setFrame:CGRectMake(0, 0, 30, 30)];
    [activity setCenter:aboveActivity.center];
    [aboveView addSubview:activity];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [activity startAnimating];
    
}


-(void)stopActivityIndicator{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    [[window viewWithTag:11] removeFromSuperview];
}



- (void)dealloc {
    self.response = nil;
    self.delegate = nil;

#if __EGOIL_USE_BLOCKS
	[handlers release], handlers = nil;
	#endif

    [_connection release];
    [_imageURL release];
    [_responseData release];
    [super dealloc];
}

@end
