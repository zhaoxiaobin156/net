//
//  DetailModel.m
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "DetailModel.h"

@implementation DetailModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"user.login":@"login"}];
}

@end
