//
//  ViewController.m
//  4-MPMoviePlayerViewController
//
//  Created by mac on 16/6/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "DetailViewController.h"
#import "MyMoviePlayerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)playBtn:(UIButton *)sender {
    
    //可以播放本地，也可以播放远程；可以播放视频和音频
    //带音视频播放的控制器
    
#if 0
    MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://10.20.158.16/1.mp4"]];
    
    [self presentViewController:playerVC animated:YES completion:nil];
#endif
    
#if 0
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    [self presentViewController:detailVC animated:YES completion:nil];
#endif
    
    MyMoviePlayerViewController *myPlayerVC = [[MyMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://10.20.158.16/1.mp4"]];
    
    [self presentViewController:myPlayerVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
