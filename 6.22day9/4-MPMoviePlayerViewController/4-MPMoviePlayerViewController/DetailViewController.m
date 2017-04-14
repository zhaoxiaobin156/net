//
//  DetailViewController.m
//  4-MPMoviePlayerViewController
//
//  Created by mac on 16/6/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
}

//是否允许自动旋转屏幕
-(BOOL)shouldAutorotate{

    return YES;
}

//支持旋转屏幕的方向
- (NSUInteger)supportedInterfaceOrientations{

    //支持左横屏和右横屏
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

//当前界面被弹出时默认的屏幕旋转方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{

    //左横屏
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
