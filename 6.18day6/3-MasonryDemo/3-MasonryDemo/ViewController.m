//
//  ViewController.m
//  3-MasonryDemo
//
//  Created by mac on 16/6/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //代码加约束：
    //先创建控件，设置控件的属性，添加到父视图，最后添加约束
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectZero];
    headView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:headView];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //添加约束：上左是正数，下右是负数
        
        //headView上面和父视图的约束是0
        make.top.equalTo(self.view.mas_top).offset(0);
        
        //headView左边和父视图的约束是0
        make.left.equalTo(self.view.mas_left).offset(0);
        
        //headView右边和父视图的约束是0
        make.right.equalTo(self.view.mas_right).offset(0);
        
        //高度约束
        make.height.equalTo(@64);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [headView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(headView.mas_top).offset(25);
        make.right.equalTo(headView.mas_right).offset(-30);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@49);
    }];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
    b.backgroundColor = [UIColor blackColor];
    [b setTitle:@"b" forState:UIControlStateNormal];
    [bottomView addSubview:b];
    
    [b mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bottomView.mas_left).offset(10);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeSystem];
    b2.backgroundColor = [UIColor blackColor];
    [b2 setTitle:@"b2" forState:UIControlStateNormal];
    [bottomView addSubview:b2];
    
    [b2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(bottomView.mas_centerX);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-10);
        make.width.equalTo(b.mas_width);
        
        //宽度是b按钮的两倍
//        make.width.equalTo(b.mas_width).multipliedBy(2);
        
        make.height.equalTo(b.mas_height);
    }];
    
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeSystem];
    b3.backgroundColor = [UIColor blackColor];
    [b3 setTitle:@"b3" forState:UIControlStateNormal];
    [bottomView addSubview:b3];
    
    [b3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(bottomView.mas_bottom).offset(-10);
        make.right.equalTo(bottomView.mas_right).offset(-10);
        make.width.equalTo(b.mas_width);
        make.height.equalTo(b.mas_height);
    }];
    
    UIView *secondBottomView = [[UIView alloc] initWithFrame:CGRectZero];
    secondBottomView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:secondBottomView];
    
    [secondBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(bottomView.mas_top).offset(-8);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@50);
    }];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectZero];
    l.backgroundColor = [UIColor orangeColor];
    l.text = @"label";
    l.textAlignment = NSTextAlignmentCenter;
    [secondBottomView addSubview:l];
    
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(secondBottomView.mas_left).offset(10);
        make.bottom.equalTo(secondBottomView.mas_bottom).offset(-5);
        make.height.equalTo(@40);
    }];
    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectZero];
    l2.backgroundColor = [UIColor orangeColor];
    l2.text = @"label2";
    l2.textAlignment = NSTextAlignmentCenter;
    [secondBottomView addSubview:l2];
    
    [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(secondBottomView.mas_centerX);
        make.bottom.equalTo(secondBottomView.mas_bottom).offset(-5);
        make.height.equalTo(l.mas_height);
        make.width.equalTo(l.mas_width);
        make.left.equalTo(l.mas_right).offset(10);
    }];
    
    UILabel *l3 = [[UILabel alloc] initWithFrame:CGRectZero];
    l3.backgroundColor = [UIColor orangeColor];
    l3.text = @"label3";
    l3.textAlignment = NSTextAlignmentCenter;
    [secondBottomView addSubview:l3];
    
    [l3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(secondBottomView.mas_bottom).offset(-5);
        make.right.equalTo(secondBottomView.mas_right).offset(-10);
        make.height.equalTo(l2.mas_height);
        make.width.equalTo(l2.mas_width);
        make.left.equalTo(l2.mas_right).offset(10);
    }];
    
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(headView.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(secondBottomView.mas_top).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
