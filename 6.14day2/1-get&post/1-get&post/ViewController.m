//
//  ViewController.m
//  1-get&post
//
//  Created by mac on 16/6/14.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "MyNetWorking.h"
#define HOST @"http://10.0.8.8/sns"
#define REGIST HOST@"/my/register.php"
#define LOGIN HOST@"/my/login.php"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //http协议常用的两种请求方式：get和post
    //get方式设计初衷是为了获取服务器数据，现实开发中也可以用于上传数据，但是存在安全隐患
    //post方式设计初衷是为了上传服务器数据，现实开发中也可以用于获取数据，有安全保障
    //上传数据：get方式只能上传少量数据，post上传的数据没有限制；post的安全性比get高
    
#if 0
    //get方式
    NSString *str = [REGIST stringByAppendingString:@"?username=ios2449608306&password=123456&email=ios123456@sina.com"];
    
//    NSLog(@"%@",str);
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            NSLog(@"错误信息 ＝ %@",connectionError);
        }else{
        
           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dic[@"message"]);
        }
    }];
#endif
    
    //post方式
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:LOGIN]];
    
    //修改请求方式为post(默认为get)
    req.HTTPMethod = @"POST";
    
    //参数转成data数据
    NSData *data = [@"username=ios2449608306&password=123456" dataUsingEncoding:NSUTF8StringEncoding];
    
    //post请求的参数单独放到请求体内
    req.HTTPBody = data;
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            NSLog(@"错误信息 ＝ %@",connectionError);
        }else{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dic[@"message"]);
        }
    }];
    
    //get方法封装
    [MyNetWorking getDataWithString:LOGIN andParam:@{@"username":@"ios2449608306",@"password":@"123456"} compliationBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            NSLog(@"错误信息 ＝ %@",connectionError);
        }else{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dic[@"message"]);
        }
    }];
    
    //post方法封装
    [MyNetWorking postDataWithString:LOGIN andParam:@{@"username":@"ios2449608306",@"password":@"123456"} compliationBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            NSLog(@"错误信息 ＝ %@",connectionError);
        }else{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dic[@"message"]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
