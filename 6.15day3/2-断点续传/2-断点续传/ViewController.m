//
//  ViewController.m
//  2-断点续传
//
//  Created by mac on 16/6/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#define QQURL @"http://sw.bos.baidu.com/sw-search-sp/software/bfe69c1ecac/QQ_4.2.1_mac.dmg"
#define QQPATH [NSHomeDirectory() stringByAppendingString:@"/Library/QQ.dmg"]

@interface ViewController ()<NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property(nonatomic,strong)NSMutableData *mutData;

@property(nonatomic,strong)NSFileHandle *fileHandle;//文件句柄

@property(nonatomic,assign)long long length;

@property(nonatomic,assign)long long lastLength;

@property(nonatomic,strong)NSURLConnection *connection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"QQPATH = %@",QQPATH);
}

-(NSMutableData *)mutData{

    if (_mutData == nil) {
        _mutData = [NSMutableData data];
    }
    return _mutData;
}

- (IBAction)startClick:(UIButton *)sender {
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:QQURL]];
    
    //通过字段RANGE告诉服务器从哪个点开始下载
    [req setValue:[NSString stringWithFormat:@"bytes=%lld-",self.lastLength] forHTTPHeaderField:@"RANGE"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:QQPATH] == NO) {
        
        //如果文件不存在，那么是第一次下载，创建文件
        [[NSFileManager defaultManager] createFileAtPath:QQPATH contents:nil attributes:nil];
    }
    
    //打开QQ文件
    self.fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:QQPATH];
    
    //光标定位到文件末尾，以便于继续写入数据
    self.lastLength = [self.fileHandle seekToEndOfFile];
    
    self.connection = [NSURLConnection connectionWithRequest:req delegate:self];
}

- (IBAction)pauseClick:(UIButton *)sender {
    
    //停止下载
    [self.connection cancel];
    
    [self.fileHandle writeData:self.mutData];
    
    [self.fileHandle closeFile];
}

- (IBAction)deleteClick:(UIButton *)sender {
    
    [[NSFileManager defaultManager] removeItemAtPath:QQPATH error:nil];
}

#pragma mark --- NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    NSLog(@"response = %@",response);
    
    //记录需要下载软件的长度
    self.length = response.expectedContentLength;
    
    self.mutData.length = 0;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    //进度条显示
    self.progressView.progress = (self.lastLength + self.mutData.length * 1.0) / self.length;
    
    [self.mutData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //把下载的文件通过文件句柄写到QQ文件
    [self.fileHandle writeData:self.mutData];
    
    //通过文件句柄关闭文件
    [self.fileHandle closeFile];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
