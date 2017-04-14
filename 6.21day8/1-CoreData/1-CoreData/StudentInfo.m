//
//  StudentInfo.m
//  
//
//  Created by mac on 16/6/21.
//
//

#import "StudentInfo.h"


@implementation StudentInfo

@dynamic name;
@dynamic age;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    NSLog(@"未定义的key ＝ %@",key);
}

//coreData的模型，如果和网络数据不一一匹配，使用KVC方法赋值，还需要重写以下方法
-(void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues{

    for (NSString *key in keyedValues) {
        
        [self setValue:keyedValues[key] forKey:key];
    }
}

@end
