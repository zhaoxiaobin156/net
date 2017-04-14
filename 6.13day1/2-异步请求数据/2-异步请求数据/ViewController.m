//
//  ViewController.m
//  2-异步请求数据
//
//  Created by mac on 16/6/13.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#define QQURL @"http://sw.bos.baidu.com/sw-search-sp/software/bfe69c1ecac/QQ_4.2.1_mac.dmg"

@interface ViewController ()<NSURLConnectionDataDelegate>

@property(nonatomic,strong)NSMutableData *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //异步请求：(block和代理的方式)
    //1.block注重的是结果
    //2.代理注重的是过程
    
#if 0
    //block方式
    //1.
    NSURL *url = [NSURL URLWithString:QQURL];
    //2.
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    //3.发起链接
    //参数一：请求对象
    //参数二：[NSOperationQueue mainQueue]
    //参数三：回调block(获取到数据后调动的block)
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //response服务器返回的响应
        //data下载数据
        //connectionError错误信息
        if (connectionError != nil) {
            
            NSLog(@"错误信息 = %@",connectionError);
        }else{
            
            //下载成功
            [[NSFileManager defaultManager] createFileAtPath:@"/Users/mac/Desktop/QQ.dmg" contents:data attributes:nil];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"下载成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alert show];
        }
    }];
    
    NSLog(@"hello world......");
#endif
    
    //代理方式
    //1.
    NSURL *url = [NSURL URLWithString:QQURL];
    //2.
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    //3.
    //参数一：请求对象
    //参数二：代理对象
    [NSURLConnection connectionWithRequest:req delegate:self];
}

//代理方法
#pragma mark --- NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    //下载文件的大小(单位是Byte)
    NSLog(@"文件大小 ＝ %lld",response.expectedContentLength);
    
    //下载文件的名字
    NSLog(@"文件名 ＝ %@",response.suggestedFilename);
    
    //状态码
    NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
    NSLog(@"状态码 = %ld",httpRes.statusCode);
    
    //清空data数据
    self.data.length = 0;
    
    NSLog(@"开始接受数据");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    //把data数据添加到self.data里面
    [self.data appendData:data];
    
//    NSLog(@"正在接受数据");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //保存下完的数据
    [[NSFileManager defaultManager] createFileAtPath:@"/Users/mac/Desktop/QQ.dmg" contents:self.data attributes:nil];
    
    NSLog(@"已经接受完了数据");
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"接受数据发生错误");
}

//重写getter方法(懒加载：用到的时候才创建对象)
//第一次调用才创建NSMutableData对象，后续的调用都是直接返回已经创建的对象_data
-(NSMutableData *)data{

    if (_data == nil) {
        _data = [NSMutableData data];
    }
    return _data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
