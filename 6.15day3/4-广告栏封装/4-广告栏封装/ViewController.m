//
//  ViewController.m
//  4-广告栏封装
//
//  Created by mac on 16/6/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "GGView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GGView *view = [[GGView alloc] initWithFrame:CGRectMake(0, 20, 375, 250)];
    
    view.dataSource = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    
    [self.view addSubview:view];
    
    view.dataSource = @[@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
