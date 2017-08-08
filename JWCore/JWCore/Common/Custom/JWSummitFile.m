//
//  JWSummitFile.m
//  qinghaishiguang
//
//  Created by mac on 14-6-25.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "JWSummitFile.h"

static JWSummitFile * summitFile;

@implementation JWSummitFile

+(JWSummitFile *) shareInstance{
    if (!summitFile) {
        summitFile=[[JWSummitFile alloc] init];
    }
    return summitFile;
}

-(NSString *)judgeFileWithFormat:(NSString *)format{
    if ([format isEqualToString:@"png"]||[format isEqualToString:@"jpg"]) {
        return @"image";
    }else if([format isEqualToString:@"aac"]){
        return @"audio";
    }else if([format isEqualToString:@"mp4"]){
        return @"vedio";
    }else{
        return @"image";
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

#pragma mark -NSURLConnectDelegate  NSURLConnectDataDelegate-

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"the connect error is %@",error);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self stopActivityIndicator];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"the response is %@",response);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"the receive data is %@",data);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    NSData * resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error=nil;
    //
    NSDictionary * resultDic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        [self.delegate httpRequestResult:resultDic];
    }
    [self stopActivityIndicator];
}


- (NSMutableURLRequest *)postRequestWithParems:(NSString *)url postParams:(NSMutableDictionary *)postParems  files:(NSDictionary *)files
{
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //分割符
    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //http 参数body的字符串
    NSMutableString *paraBody=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [postParems allKeys];
    //遍历keys
    for(int i = 0; i < [keys count] ; i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //添加分界线，换行
        [paraBody appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [paraBody appendFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n",key];
        //添加字段的值
        [paraBody appendFormat:@"%@\r\n",[postParems objectForKey:key]];
        
        NSLog(@"参数%@ == %@",key,[postParems objectForKey:key]);
    }
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData = [[NSMutableData alloc] init];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[paraBody dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray * fileKeys=[files allKeys];
    NSLog(@"%d",fileKeys.count);
    for (int i = 0; i < fileKeys.count; i++)
    {
        NSMutableString *imageBody = [[NSMutableString alloc] init];
        NSData *imageData = nil;
        //判断图片是不是png格式的文件
        //返回为png图像。
        NSString * fileKey=[fileKeys objectAtIndex:i];
        imageData = [files objectForKey:fileKey];
//        if (UIImagePNGRepresentation(images[i]))
//        {
//            //返回为png图像。
//            imageData = UIImagePNGRepresentation(images[i]);
//        }else
//        {
//            //返回为JPEG图像。
//            imageData = UIImageJPEGRepresentation(images[i], 1.0);
//        }
        
        NSString *name = [NSString stringWithFormat:@"%@",fileKey];
        NSString *fileNmae = [NSString stringWithFormat:@"%@.png",fileKey];
        //添加分界线，换行
        [imageBody appendFormat:@"%@\r\n",MPboundary];
        //声明pic字段，文件名为boris.png
        [imageBody appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",name,fileNmae];
        //声明上传文件的格式
//        [imageBody appendFormat:@"Content-Type: image/png\r\n\r\n"];
        [imageBody appendFormat:@"Content-Type: %@/%@\r\n\r\n",[self judgeFileWithFormat:@"png"],@"png"];
        //将image的data加入
        
        [myRequestData appendData:[imageBody dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData appendData:[[NSData alloc] initWithData:imageData]];
        [myRequestData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    ////////////////////////////////////////////////////////////
    //建立连接，设置代理
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    //设置接受response的data
    if (conn) {
        NSData * mResponseData = [NSMutableData data];
    }
    //菊花
    [self startActivityIndicator];
    //////////////////////////////////////////////////
    return request;
}

@end
