//
//  ViewController.m
//  2-KVC处理复杂的网络数据例子
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dic = @{@"name":@"小明",
                          @"age":@"18",
                          @"weight":@"65",
                          @"height":@"170",
                          @"description":@"描述",
                          @"array":@[@{@"color":@"红色",@"name":@"小红"},
                                   @{@"color":@"黄色",@"name":@"小黄"},
                                   @{@"color":@"黑色",@"name":@"小黑"}]
                          };
    
    Model *mod = [[Model alloc] init];
    
    [mod setValuesForKeysWithDictionary:dic];
    
    NSLog(@"mod = %@",mod);
    
    for (Dog *dog in mod.dogMutArr) {
        
        NSLog(@"%@ --- %@",dog.color,dog.name);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
