//
//  MovieModel.m
//  4-解析练习
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "MovieModel.h"

@implementation CastsModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"avatars.small":@"small"}];
}

@end

@implementation MovieModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"subject.title":@"title",@"subject.images.small":@"small", @"subject.casts":@"castsArr"}];
}

@end
