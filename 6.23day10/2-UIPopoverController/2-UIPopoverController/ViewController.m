//
//  ViewController.m
//  2-UIPopoverController
//
//  Created by mac on 16/6/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()<UIPopoverControllerDelegate,UIPopoverPresentationControllerDelegate>//<ChangeColorDelegate>

@property(nonatomic,strong)UIPopoverController *popoverC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 300, 100, 50);
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"气泡" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"气泡" style:UIBarButtonItemStylePlain target:self action:@selector(clickItem:)];
}

-(void)clickBtn:(UIButton *)btn{

    self.navigationItem.title = @"泡泡出现了";
    
    TableViewController *tableVC = [[TableViewController alloc] init];
    
//    tableVC.delegate = self;
    
    tableVC.block = ^(UIColor *color){
    
        self.view.backgroundColor = color;
        
        [self.popoverC dismissPopoverAnimated:YES];
    };
    
    //通过显示的内容来创建气泡控制器
    self.popoverC = [[UIPopoverController alloc] initWithContentViewController:tableVC];
    
    //设置气泡控制器的大小
    self.popoverC.popoverContentSize = CGSizeMake(250, 300);
    
    //设置气泡控制器的代理
    self.popoverC.delegate = self;
    
    //弹出
    //参数一：从哪个区域弹出
    //参数二：在哪个当前view显示
    //参数三：弹出的方向(UIPopoverArrowDirectionLeft表示从左边弹出)
    [self.popoverC presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];

#if 0
    //ios8的新API：会自动销毁掉气泡控制器
    
    //将视图控制器弹出样式设置为泡泡
    tableVC.modalPresentationStyle = UIModalPresentationPopover;
    
    //从哪个视图弹出
    tableVC.popoverPresentationController.sourceView = self.view;
    
    //设置代理
    tableVC.popoverPresentationController.delegate = self;
    
    //设置弹出方向
    tableVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionLeft;
    
    //设置弹出区域
    tableVC.popoverPresentationController.sourceRect = CGRectMake(100, 300, 100, 50);
    
    //弹出
    [self presentViewController:tableVC animated:YES completion:nil];
#endif
}

-(void)clickItem:(UIBarButtonItem *)item{
    
    TableViewController *tableVC = [[TableViewController alloc] init];
    
//    tableVC.delegate = self;
    
    tableVC.block = ^(UIColor *color){
        
        self.view.backgroundColor = color;
        
        [self.popoverC dismissPopoverAnimated:YES];
    };
    
    self.popoverC = [[UIPopoverController alloc] initWithContentViewController:tableVC];
    
    self.popoverC.popoverContentSize = CGSizeMake(250, 300);
    
    //弹出
    //参数一：从哪个区域弹出
    //参数二：弹出的方向(UIPopoverArrowDirectionAny表示合适方向)
    [self.popoverC presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)changeColor:(UIColor *)color{

    self.view.backgroundColor = color;
    
    [self.popoverC dismissPopoverAnimated:YES];
}

#pragma mark --- UIPopoverControllerDelegate

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{

    self.navigationItem.title = @"泡泡消失了";
}

#pragma mark --- UIPopoverPresentationControllerDelegate

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{

    self.navigationItem.title = @"ios8泡泡消失了";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
