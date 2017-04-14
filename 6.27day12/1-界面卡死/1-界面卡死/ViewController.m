//
//  ViewController.m
//  1-界面卡死
//
//  Created by mac on 16/6/27.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //ios中线程分为两种：
    //1.主线程：程序启动，系统创建
    //2.子线程(工作线程)：用户手动创建
    
    //如果在主线程睡眠或者在主线程做耗时较长的任务，就会卡死
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    for (int i = 0; i < 10; i++) {
        
        NSLog(@"i = %d",i);
        
        //让当前线程睡眠1秒
        [NSThread sleepForTimeInterval:1.0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
