//
//  ViewController.m
//  2-MagicalRecord
//
//  Created by mac on 16/6/21.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "StudentInfo.h"
#import "MagicalRecord.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",[NSHomeDirectory() stringByAppendingString:@"/Library"]);
}

- (IBAction)insertDataBtn:(UIButton *)sender {
    
    //创建模型对象
    StudentInfo *stu = [StudentInfo MR_createEntity];
    
    stu.name = [NSString stringWithFormat:@"张三%d",arc4random_uniform(100)];
    stu.age = [NSString stringWithFormat:@"%d",arc4random_uniform(100)];
    
    //保存
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (IBAction)deleteDataBtn:(UIButton *)sender {
    
    //查找
    //查找全部
    NSArray *arr = [StudentInfo MR_findAll];

#if 0
    //按排序查找
    NSArray *arr2 = [StudentInfo MR_findAllSortedBy:@"age" ascending:YES];
    
    //按条件查找
    NSArray *arr3 = [StudentInfo MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"age > 18"]];
    
    //按照条件排序查找
//    [StudentInfo MR_findAllSortedBy:<#(NSString *)#> ascending:<#(BOOL)#> withPredicate:<#(NSPredicate *)#> inContext:<#(NSManagedObjectContext *)#>];
#endif
    
    //删除所有数据
    [[NSManagedObjectContext MR_defaultContext] MR_deleteObjects:arr];
    
    //删除指定数据
//    [StudentInfo MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"name = '张三2'"]];
    
    //保存
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (IBAction)searchDataBtn:(UIButton *)sender {
    
    NSArray *arr = [StudentInfo MR_findAll];
    
    for (StudentInfo *stu in arr) {
        
        NSLog(@"name = %@ --- age = %@",stu.name,stu.age);
    }
}

- (IBAction)updateDataBtn:(UIButton *)sender {
    
    NSArray *arr = [StudentInfo MR_findAll];
    
    for (StudentInfo *stu in arr) {
        
        stu.name = [NSString stringWithFormat:@"李四%d",arc4random_uniform(100)];
        stu.age = [NSString stringWithFormat:@"%d",arc4random_uniform(100)];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
