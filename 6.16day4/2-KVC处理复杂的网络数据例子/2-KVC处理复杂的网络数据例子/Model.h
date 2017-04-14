//
//  Model.h
//  2-KVC处理复杂的网络数据例子
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject

@property(nonatomic,copy)NSString *color;

@property(nonatomic,copy)NSString *name;

@end

@interface Model : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *age;

@property(nonatomic,copy)NSString *weight;

@property(nonatomic,copy)NSString *des;

@property(nonatomic,strong)NSMutableArray *dogMutArr;

@end
