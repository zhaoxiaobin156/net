//
//  FashionModel.m
//  2-瀑布流
//
//  Created by mac on 16/6/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "FashionModel.h"

@implementation FashionModel

+(JSONKeyMapper *)keyMapper{

    return [[JSONKeyMapper alloc] initWithDictionary:@{@"component.picUrl":@"picUrl",@"component.description":@"des"}];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName{

    return YES;
}

@end
