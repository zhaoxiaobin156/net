//
//  ViewController.m
//  4-自定义控件的适配
//
//  Created by mac on 16/6/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CustomView *myCustomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CustomView *customView = [[CustomView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    customView.label.text = @"cat4";
    customView.imgView.image = [UIImage imageNamed:@"cat4.jpg"];
    [self.view addSubview:customView];
    
    customView.frame = CGRectMake(50, 100, 300, 300);
    
    self.myCustomView.label.text = @"拖控件cat3";
    self.myCustomView.imgView.image = [UIImage imageNamed:@"cat3.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
