//
//  Model.h
//  3-JSONModelDemo
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface Dog : NSObject

@property(nonatomic,copy)NSString *color;

@property(nonatomic,copy)NSString *name;

@end

//声明一个协议
@protocol Dog;

@interface Model : JSONModel

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *age;

@property(nonatomic,copy)NSString *weight;

@property(nonatomic,copy)NSString *des;

//如果网络数据有key，模型没有key，不写方法也不会奔溃

//如果模型有key，而网络数据没有key，则需要做处理：
//处理方法一：属性前添加<Optional>
@property(nonatomic,copy)NSString <Optional>*sex;

@property(nonatomic,strong)NSArray <Dog>*dogArr;

@property(nonatomic,copy)NSString *sisterAge;

@end
