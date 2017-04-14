//
//  ViewController.m
//  1-KVC处理复杂的网络数据
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dic = @{@"name":@"小明",@"age":@"18",@"weight":@"65",@"height":@"170",@"description":@"纠结的网络数据"};
    
    Person *per = [[Person alloc] init];
    
    [per setValue:dic[@"name"] forKey:@"name"];
    [per setValue:dic[@"age"] forKey:@"age"];
    [per setValue:dic[@"weight"] forKey:@"weight"];
    
    NSLog(@"name = %@ --- age = %@ --- weight = %@",[per valueForKey:@"name"],[per valueForKey:@"age"],[per valueForKey:@"weight"]);
    
    //使用KVC赋值，如果对象没有该属性，会奔溃
    [per setValue:dic[@"height"] forKey:@"height"];
    
    //使用KVC获取属性值，如果对象没有该属性，会奔溃
    NSLog(@"height = %@",[per valueForKey:@"height"]);
    
//    [per setValuesForKeysWithDictionary:dic];
    
    //内部遍历字典赋值
//    for (NSString *key in dic) {
//        
//        [per setValue:dic[key] forKey:key];
//    }
    
    //访问属性的属性
    [per setValue:@"灰色" forKeyPath:@"dog.color"];
    
    NSLog(@"color = %@",[per valueForKeyPath:@"dog.color"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
