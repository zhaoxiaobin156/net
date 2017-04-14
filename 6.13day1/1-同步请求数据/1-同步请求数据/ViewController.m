//
//  ViewController.m
//  1-同步请求数据
//
//  Created by mac on 16/6/13.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#define ImgURL @"http://pic32.nipic.com/20130829/12906030_124355855000_2.png"
#define BaiDuURL @"https://www.baidu.com"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#if 0
    //字符串 -> URL
    NSURL *url = [NSURL URLWithString:ImgURL];
    
    //同步下载网络数据
    //通过url同步下载网络二进制数据
    //(备注：同步下载：等到下载完数据，程序才会往下跑，阻塞主线程)
    //每一个app只有一个主线程
    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSLog(@"data = %@",data);
    
    //把下载的图片数据显示出来
    _imgView.image = [UIImage imageWithData:data];
#endif

    //webView控件显示网页
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:BaiDuURL];
    
    //URL -> request网络请求
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    //webView加载网络请求
    [webView loadRequest:req];
    
    //适应大小
    webView.scalesPageToFit = YES;
    
    //返回上一级
//    [webView goBack];
    
    //前进一级
//    [webView goForward];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
