//
//  ViewController.m
//  2-AFNetWorkingDemo
//
//  Created by mac on 16/6/14.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

#if 0
    //get请求
    //创建操作管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //参数一：URL
    //参数二：URL的参数
    //参数三：成功调用的block
    //参数四：失败调用的block
    [manager GET:@"http://10.0.8.8/sns/my/login.php" parameters:@{@"username":@"ios2449608306",@"password":@"123456"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //responseObject：响应数据
        NSLog(@"%@",responseObject[@"message"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息 ＝ %@",error);
    }];
    
    //修改响应解析器
    //二进制响应解析器
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //Json响应解析器(默认)
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //XML响应解析器
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    AFHTTPRequestOperation *op = [manager GET:@"http://sw.bos.baidu.com/sw-search-sp/software/bfe69c1ecac/QQ_4.2.1_mac.dmg" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSHTTPURLResponse *res = operation.response;
        
        //把响应头的一些信息打印出来：包括文件名，文件大小。。。
        NSLog(@"信息 = %@",res.allHeaderFields);
        
        //状态码
        NSLog(@"状态码 = %ld",res.statusCode);
        
        //保存到桌面
        [[NSFileManager defaultManager] createFileAtPath:@"/Users/mac/Desktop/QQ.dmg" contents:responseObject attributes:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息 ＝ %@",error);
    }];
    
    //检测进度
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        NSLog(@"本次下载大小：%ld, 已经下载大小：%lld, 总共需要下载的大小：%lld", bytesRead, totalBytesRead, totalBytesExpectedToRead);
    }];
#endif

//#if 0
    //post请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:@"http://10.0.8.8/sns/my/login.php" parameters:@{@"username":@"ios2449608306",@"password":@"123456"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject[@"message"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息 ＝ %@",error);
    }];
//#endif
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
