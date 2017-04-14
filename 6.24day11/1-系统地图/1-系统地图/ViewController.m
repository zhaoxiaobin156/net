//
//  ViewController.m
//  1-系统地图
//
//  Created by mac on 16/6/24.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate>//遵守定位管理协议

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#if 0
    //创建地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:mapView];
#endif
    
    //深大地址 22.533367, 113.935404
    //西丽地址 22.581200, 113.953007
}

- (IBAction)clickItem:(UIBarButtonItem *)sender {
    
    //创建经纬度对象
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(22.581200, 113.953007);
    
    //创建范围
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.02);
    
    //经纬度和范围合成区域
    MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
    
    //让地图显示区域
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)clickSeg:(UISegmentedControl *)sender {
    
//    MKMapTypeStandard = 0
//    MKMapTypeSatellite
//    MKMapTypeHybrid
    self.mapView.mapType = sender.selectedSegmentIndex;
}

- (IBAction)clickLocal:(UIBarButtonItem *)sender {
    
    //ios8.0之后需要申请定位权限：
    //1.[UIDevice currentDevice]是单例
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        //申请权限
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //2.需要在Info.plist中加入两个缺省没有的字段NSLocationAlwaysUsageDescription和Privacy - Location Usage Description
    
    //开始定位
    [self.locationManager startUpdatingLocation];
}

-(CLLocationManager *)locationManager{

    if (_locationManager == nil) {
        
        _locationManager = [[CLLocationManager alloc] init];
        
        //设置代理
        _locationManager.delegate = self;
    }
    return _locationManager;
}

#pragma mark --- CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    NSLog(@"定位成功");
    
    //地点位置
    CLLocation *location = locations[0];
    
    //让地图显示该地点
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, self.mapView.region.span);
    
    [self.mapView setRegion:region animated:YES];
    
    //添加大头针(标注)
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    
    //设置大头针的经纬度
    pa.coordinate = location.coordinate;
    
    //设置titlt
    pa.title = @"我的位置";
    
    //地图添加大头针
    [self.mapView addAnnotation:pa];
    
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"定位失败");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
