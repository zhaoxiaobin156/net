//
//  HomeModel.m
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "HomeModel.h"

@implementation HomeModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"user.login": @"login", @"votes.up": @"up", @"id":@"myId"}];
}

@end
