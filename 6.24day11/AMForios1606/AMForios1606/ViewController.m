//
//  ViewController.m
//  AMForios1606
//
//  Created by mac on 16/6/24.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#define ApiKEY @"25c9af0423775ba2c4bad360617f9270"

@interface ViewController ()<MAMapViewDelegate>

@property(nonatomic,strong)MAMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //获取安全码
//    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
//    NSLog(@"%@",bundleIdentifier);
    
    [AMapServices sharedServices].apiKey = ApiKEY;
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
