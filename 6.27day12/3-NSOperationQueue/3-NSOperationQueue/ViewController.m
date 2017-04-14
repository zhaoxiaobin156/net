//
//  ViewController.m
//  3-NSOperationQueue
//
//  Created by mac on 16/6/27.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CustomOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //线程(任务)队列，里面放的是线程
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //设置队列当中最大并行任务数量
//    queue.maxConcurrentOperationCount = 1;
    
    //任务有三种
    //1.NSInvocationOperation
    NSInvocationOperation *invocationOP = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation) object:nil];
    
    //如果想使用任务，就必须将它加入到任务队列当中
    [queue addOperation:invocationOP];
    
    //2.带有block任务
    NSBlockOperation *blockOP = [NSBlockOperation blockOperationWithBlock:^{
        
        for (int i = 0; i < 10; i++) {
            
            NSLog(@"blockOP:i = %d",i);
            
            [NSThread sleepForTimeInterval:1.0];
        }
    }];
    
    [queue addOperation:blockOP];
    
    //3.用户自定义的任务
    
    NSArray *urlArr = [NSArray arrayWithObjects:@"http://s8.mogucdn.com/pic/141109/49ssv_ieydmolegjsdqyzwmqytambqgiyde_173x80.jpg", @"http://s8.mogucdn.com/pic/141118/7jax4_ieydkntggvrwknzzmqytambqmmyde_173x80.jpg", @"http://s7.mogucdn.com/pic/141111/anxuan_ieygkyjzgnsdanrxmqytambqmmyde_173x80.jpg", nil];
    
    for (int i = 0; i < urlArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100 + 90 * i, 173, 80)];
        imgView.backgroundColor = [UIColor redColor];
        imgView.tag = 100 + i;
        [self.view addSubview:imgView];
        
        CustomOperation *customOP = [[CustomOperation alloc] initWithUrl:urlArr[i] andBlock:^(NSData *data, CustomOperation *operation) {
            
            UIImageView *imgView = (UIImageView *)[self.view viewWithTag:operation.tag];
            imgView.image = [UIImage imageWithData:data];
        }];
        
        //将imgView和任务对应
        customOP.tag = 100 + i;
        
        [queue addOperation:customOP];
    }
}

-(void)operation{

    for (int i = 0; i < 10; i++) {
        
        NSLog(@"invocationOP:i = %d",i);
        
        [NSThread sleepForTimeInterval:1.0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
