//
//  Model.m
//  2-KVC处理复杂的网络数据例子
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "Model.h"

@implementation Dog

@end

@implementation Model

-(NSString *)description{

    return [NSString stringWithFormat:@"name = %@ --- age = %@ --- weight = %@ --- des = %@",self.name,self.age,self.weight,self.des];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"key = %@ --- value = %@",key,value);
    
    //截取未定义的key
    if ([key isEqualToString:@"description"]) {
        
        [self setValue:value forKey:@"des"];
        
    }else if ([key isEqualToString:@"array"]){
    
        self.dogMutArr = [NSMutableArray array];
        
        for (NSDictionary *dic in value) {
            
            Dog *dog = [[Dog alloc] init];
            
            [dog setValuesForKeysWithDictionary:dic];
            
            [self.dogMutArr addObject:dog];
        }
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}

@end
