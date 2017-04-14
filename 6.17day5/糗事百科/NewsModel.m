//
//  NewsModel.m
//  
//
//  Created by lgh on 16/4/6.
//
//

#import "NewsModel.h"

@implementation NewsModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"style.type":@"type", @"style.images":@"images"}];
}

@end
