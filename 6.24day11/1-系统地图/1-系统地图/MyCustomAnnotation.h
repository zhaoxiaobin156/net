//
//  MyCustomAnnotation.h
//  1-系统地图
//
//  Created by mac on 16/6/24.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

//自定义大头针
//a.继承NSObject
//b.遵守协议
//c.一定要有经纬度属性
@interface MyCustomAnnotation : NSObject<MKAnnotation>

//一定要有的属性
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *phoneNumber;

@property(nonatomic,strong)NSURL *url;

@end
