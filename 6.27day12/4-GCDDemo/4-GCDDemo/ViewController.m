//
//  ViewController.m
//  4-GCDDemo
//
//  Created by mac on 16/6/27.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){

    dispatch_queue_t _mainQueue;//主队列
    dispatch_queue_t _globalQueue;//全局队列
    dispatch_queue_t _userQueue;//用户队列
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //获取主队列，等同于主线程(串行队列)
    _mainQueue = dispatch_get_main_queue();
    
    //使用(block里面是任务(operation)，队列(queue)负责执行任务)
    dispatch_async(_mainQueue, ^{
       
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300, 80)];
        label.text = @"hello";
        [self.view addSubview:label];
    });
    
    //获取全局队列，等同于子线程(并行队列)
    _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(_globalQueue, ^{
        
        int i = 0;
        
        while (1) {
            
            i++;
                
            NSLog(@"globalQueue:i = %d",i);
                
            [NSThread sleepForTimeInterval:1.0];
            
        }
    });
    
    //用户创建队列
    //DISPATCH_QUEUE_SERIAL        串行队列
    //DISPATCH_QUEUE_CONCURRENT    并行队列
    _userQueue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(_userQueue, ^{
        
        NSLog(@"userQueue:hello world");
    });
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(30, 100, 300, 30)];
    [self.view addSubview:progressView];
    
    dispatch_async(_globalQueue, ^{
        
        for (int i = 1; i <= 10; i++) {
            
            //在全局队列中嵌套一个主队列就可以刷新UI
            dispatch_async(_mainQueue, ^{
                
               [progressView setProgress:i * 0.1 animated:YES];
            });
            
//            [progressView setProgress:i * 0.1 animated:YES];
            
            [NSThread sleepForTimeInterval:1.0];
            
            NSLog(@"globalQueue:进度 = %f",i * 0.1);
        }
    });
    
//    [self testMainQueue];
    
//    [self testGlobalQueue];
    
    [self testUserQueue];
}

-(void)testMainQueue{
    
    //主队列使用多个任务
    
    //同步调度：把任务添加到指定队列，必须等到任务完成才能继续
//    dispatch_sync(<#dispatch_queue_t queue#>, <#^(void)block#>)
    
    //异步调度：把任务添加到指定队列，不须等到任务完成才能继续
//    dispatch_async(<#dispatch_queue_t queue#>, <#^(void)block#>)
    
    //同步调用主队列：阻塞主线程，必须等到A打印完成后才会往下走，但block的调用是在block实现之后，而此时主线程已经阻塞，使block调用不能被执行，从而形成死锁，导致界面卡死，不能使用
    //异步调用主队列：ABCD依次打印，串行
    dispatch_async(_mainQueue, ^{
        NSLog(@"A");
    });
    dispatch_async(_mainQueue, ^{
        NSLog(@"B");
    });
    dispatch_async(_mainQueue, ^{
        NSLog(@"C");
    });
    dispatch_async(_mainQueue, ^{
        NSLog(@"D");
    });
}

-(void)testGlobalQueue{

    //同步调用任务：abcd依次打印，串行
    //异步调用任务：无序
    dispatch_async(_globalQueue, ^{
        NSLog(@"a");
    });
    dispatch_async(_globalQueue, ^{
        NSLog(@"b");
    });
    dispatch_async(_globalQueue, ^{
        NSLog(@"c");
    });
    dispatch_async(_globalQueue, ^{
        NSLog(@"d");
    });
}

-(void)testUserQueue{

    //同步调用 ＋ 创建时指定为串行：1234依次打印，串行
    //异步调用 ＋ 创建时指定为串行：1234依次打印，串行
    //同步调用 ＋ 创建时指定为并行：1234依次打印，串行
    //异步调用 ＋ 创建时指定为并行：无序
    dispatch_sync(_userQueue, ^{
        NSLog(@"1");
    });
    dispatch_sync(_userQueue, ^{
        NSLog(@"2");
    });
    dispatch_sync(_userQueue, ^{
        NSLog(@"3");
    });
    dispatch_sync(_userQueue, ^{
        NSLog(@"4");
    });
}

-(instancetype)shareInstance{

    static ViewController *vc = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        vc = [[ViewController alloc] init];
    });
    
    return vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
