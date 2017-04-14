//
//  Model.m
//  3-JSONModelDemo
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "Model.h"

@implementation Dog

@end

@implementation Model

//处理方法二：
+(BOOL)propertyIsOptional:(NSString *)propertyName{

    //如果属性名是sex，返回YES，表示可选
    if ([propertyName isEqualToString:@"sex"]) {
        return YES;
    }
    return NO;
}

//用下面方法代替截取未定义的key方法
+(JSONKeyMapper *)keyMapper{

    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"des",@"array":@"dogArr",@"sister.age":@"sisterAge"}];
}

@end
