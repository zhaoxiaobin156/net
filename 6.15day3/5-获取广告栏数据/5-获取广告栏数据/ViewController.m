//
//  ViewController.m
//  5-获取广告栏数据
//
//  Created by lgh on 16/6/15.
//  Copyright (c) 2016年 lgh. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "GGView.h"

@interface ViewController ()

@property (nonatomic, strong) GGView *ggView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ggView = [[GGView alloc] initWithFrame:CGRectMake(0, 20, 375, 250)];
    
    self.ggView.block = ^(NSInteger item){
    
        NSLog(@"%ld",item);
    };
    
    [self.view addSubview:self.ggView];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://cloud.yijia.com/yunying/spzt.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            
            [mutArr addObject:dic[@"iphoneimg"]];
        }
        
        self.ggView.dataSource = mutArr;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end











