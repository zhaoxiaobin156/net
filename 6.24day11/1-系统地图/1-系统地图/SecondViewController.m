//
//  SecondViewController.m
//  1-系统地图
//
//  Created by mac on 16/6/24.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import <MapKit/MapKit.h>

@interface SecondViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(22.581200, 113.953007);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.02);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coord, span);
    
    [self.mapView setRegion:region animated:YES];
    
    //在地图上添加长按手势
    UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickLp:)];
    
    [self.mapView addGestureRecognizer:lp];
}

-(void)clickLp:(UILongPressGestureRecognizer *)lp{

    //开始长按
    if (lp.state == UIGestureRecognizerStateBegan) {
        
        //获取长按在地图上的点
        CGPoint point = [lp locationInView:self.mapView];
        
        //将点转成经纬度
        CLLocationCoordinate2D coord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        
        //通过经纬度创建地点对象
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
        
        //编码对象
        CLGeocoder *coder = [[CLGeocoder alloc] init];
        
        //反向编码
        [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            
            if (error) {
                
                NSLog(@"错误信息 ＝ %@",error);
            }else{
                
                //反向编码后，数组里面存储所有的地址信息对象
                for (CLPlacemark *place in placemarks) {
                    
                    NSLog(@"%@ --- %@ --- %@",place.name,place.locality,place.thoroughfare);
                    
                    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
                    
                    pa.coordinate = location.coordinate;
                    
                    pa.title = place.name;
                    pa.subtitle = place.thoroughfare;
                    
                    [self.mapView addAnnotation:pa];
                }
            }
        }];
    }
}

#pragma mark --- UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    CLGeocoder *coder = [[CLGeocoder alloc] init];
    
    [coder geocodeAddressString:textField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            
            NSLog(@"错误信息 ＝ %@",error);
        }else{
            
            for (CLPlacemark *place in placemarks) {
                
                NSLog(@"%@ --- %@ --- %@",place.name,place.locality,place.thoroughfare);
                
                NSLog(@"地理坐标经纬度 = %f,%f",place.location.coordinate.latitude,place.location.coordinate.longitude);
                
                [self.mapView setRegion:MKCoordinateRegionMake(place.location.coordinate, self.mapView.region.span) animated:YES];
                
                MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
                
                pa.coordinate = place.location.coordinate;
                
                pa.title = place.name;
                
                [self.mapView addAnnotation:pa];
            }
        }
    }];
    
    //收起键盘
    //1.
//    [textField resignFirstResponder];
    
    //2.(textF放在导航控制器的titleView上)
    [self.navigationItem.titleView endEditing:YES];
    
    return YES;
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
