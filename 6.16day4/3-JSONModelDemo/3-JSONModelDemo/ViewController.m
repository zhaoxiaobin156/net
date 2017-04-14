//
//  ViewController.m
//  3-JSONModelDemo
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
                          @"sister":@{@"age":@"16",@"name":@"小红"},
                          @"array":@[@{@"color":@"红色",@"name":@"小红"},
                                     @{@"color":@"黄色",@"name":@"小黄"},
                                     @{@"color":@"黑色",@"name":@"小黑"}]
                          };
    
    Model *mod = [[Model alloc] initWithDictionary:dic error:nil];
    
    //JSONModel已经做了：
    //1.description
    NSLog(@"mod = %@",mod);
    
    //2.深拷贝
//    Model *mod2 = [mod copy];
//    NSLog(@"mod2 = %@",mod2);
    
    //3.归档
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
