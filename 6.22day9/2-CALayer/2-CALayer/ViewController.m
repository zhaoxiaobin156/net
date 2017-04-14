//
//  ViewController.m
//  2-CALayer
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    //设置圆角
    view.layer.cornerRadius = 50;
    
    //设置边框的宽度和颜色
    view.layer.borderWidth = 3.0;
    view.layer.borderColor = [[UIColor redColor] CGColor];
    
    //设置阴影偏移量和颜色
    view.layer.shadowOffset = CGSizeMake(50, 50);
    view.layer.shadowColor = [[UIColor grayColor] CGColor];
    
    //设置阴影的透明度
    view.layer.shadowOpacity = 1.0;
    
#if 0
    //设置显示的内容(切掉超出部分阴影会看不见，不切看得见)
    view.layer.contents = (id)[[UIImage imageNamed:@"cat4.jpg"] CGImage];
    
    //切掉超出的部分内容(不管设不设内容阴影都看不见)
    view.layer.masksToBounds = YES;
#endif
    
    //如果要显示图片，也要显示圆角，也要显示阴影
    //创建一个新的CALayer对象
    CALayer *layer = [[CALayer alloc] init];
    
    //设置新的layer内容
    layer.contents = (id)[[UIImage imageNamed:@"cat4.jpg"] CGImage];
    
    layer.masksToBounds = YES;
    
    layer.cornerRadius = 50;
    
    layer.frame = view.bounds;
    
    [view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
