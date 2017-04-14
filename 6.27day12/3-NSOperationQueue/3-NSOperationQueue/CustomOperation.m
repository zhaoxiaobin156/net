//
//  CustomOperation.m
//  3-NSOperationQueue
//
//  Created by mac on 16/6/27.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "CustomOperation.h"

@interface CustomOperation ()<NSURLConnectionDataDelegate>

@end

@implementation CustomOperation

-(instancetype)initWithUrl:(NSString *)url andBlock:(myBlock)block{

    if (self = [super init]) {
        
        _url = url;
        _mutData = [NSMutableData data];
        _block = block;
    }
    return self;
}

//如果自定义NSOperation，一定要重写main方法(执行addOperation:方法后会走)
-(void)main{

    NSURL *myUrl = [NSURL URLWithString:_url];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:myUrl];
    
    [NSURLConnection connectionWithRequest:req delegate:self];
    
    //为了让任务不立刻结束
    //永远不会到达的时间
    NSDate *date = [NSDate distantFuture];
    NSLog(@"date = %@",date);
    
    //启动循环事件，一直跑
    //主线程的runloop默认开启
    //子线程的runloop默认关闭
    //runloop让线程有事情就做事，没事情就休息
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:date];
}

#pragma mark --- NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    _mutData.length = 0;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    [_mutData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

    //下载完毕，进行回调
    if (_block) {
        
        _block(_mutData,self);
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    NSLog(@"下载图片数据失败，error = %@",error);
}

@end
