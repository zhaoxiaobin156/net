//
//  ThirdViewController.m
//  1-系统地图
//
//  Created by mac on 16/6/24.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ThirdViewController.h"
#import <MapKit/MapKit.h>
#import "MyCustomAnnotation.h"
#import "DetailsViewController.h"
#import "MyCustomButton.h"

@interface ThirdViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic,copy)NSString *imgName;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(22.533367, 113.935404);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.02);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)clickSeg:(UISegmentedControl *)sender {
  
    //移除之前的所有大头针
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    NSString *title = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    
    self.imgName = title;
    
    //搜索请求对象
    MKLocalSearchRequest *req = [[MKLocalSearchRequest alloc] init];
    
    //设置搜索的关键点
    req.naturalLanguageQuery = title;
    
    //设置搜索的区域
    req.region = self.mapView.region;
    
    //通过搜索请求对象创建搜索对象
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:req];
    
    //开始发起搜索
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        if (error) {
            
            NSLog(@"错误信息 ＝ %@",error);
        }else{
        
            //搜索到的结果都在response.mapItems数组里面
            for (MKMapItem *item in response.mapItems) {
                
                NSLog(@"%@ --- %@ --- %@",item.name,item.phoneNumber,item.url);
                
#if 0
                MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
                
                pa.coordinate = item.placemark.coordinate;
                
                pa.title = item.name;
                
                [self.mapView addAnnotation:pa];
#endif
                MyCustomAnnotation *mca = [[MyCustomAnnotation alloc] init];
                
                mca.coordinate = item.placemark.coordinate;
                
                mca.title = item.name;
                mca.url = item.url;
                
                [self.mapView addAnnotation:mca];
            }
        }
    }];
}

#pragma mark --- MKMapViewDelegate

//每添加一个大头针，会调用一次地图的代理方法，可以在方法里面定制大头针样式
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    //annotation实际上就是大头针的对象
    MyCustomAnnotation *mca = annotation;
    
//    NSLog(@"%@",mca.url);
    
    //复用机制
    MKAnnotationView *mkaView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"cell"];
    
    if (mkaView == nil) {
        
        mkaView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"cell"];
    }
    
    //设置样式
    mkaView.image = [UIImage imageNamed:self.imgName];
    
    //设置显示信息
    mkaView.canShowCallout = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    label.backgroundColor = [UIColor yellowColor];
    label.text = [NSString stringWithFormat:@"%d星级",arc4random_uniform(5) + 1];
    label.textAlignment = NSTextAlignmentCenter;
    
    //设置左视图
    mkaView.leftCalloutAccessoryView = label;
    
    MyCustomButton *button = [MyCustomButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button setTitle:@"主页" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    button.url = mca.url;
    
    //设置右视图
    mkaView.rightCalloutAccessoryView = button;
    
    return mkaView;
}

-(void)clickBtn:(MyCustomButton *)btn{

    if (btn.url != nil) {
        
        DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
        
        detailsVC.url = btn.url;
        
        detailsVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
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
