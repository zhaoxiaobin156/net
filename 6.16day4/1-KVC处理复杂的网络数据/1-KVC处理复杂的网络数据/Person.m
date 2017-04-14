//
//  Person.m
//  1-KVC处理复杂的网络数据
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "Person.h"

@implementation Dog

@end

@interface Person ()

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *age;

@property(nonatomic,copy)NSString *weight;

@property(nonatomic,strong)Dog *dog;

@end

@implementation Person

-(instancetype)init{

    if (self = [super init]) {
        
        self.dog = [[Dog alloc] init];
    }
    return self;
}

//重写以下方法，当使用KVC赋值时，即使没有该属性也不会奔溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    NSLog(@"key = %@ --- value = %@",key,value);
}

//重写以下方法，当使用KVC获取属性值时，即使没有该属性也不会奔溃
-(id)valueForUndefinedKey:(NSString *)key{

    return nil;
}

@end
