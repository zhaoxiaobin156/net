//
//  ViewController.m
//  1-CoreData
//
//  Created by mac on 16/6/21.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StudentInfo.h"//coreData导出的模型类

@interface ViewController ()

//上下文操作
@property(nonatomic,strong)NSManagedObjectContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //sqlite轻量级数据库
    //FMDB第三方框架对sqlite数据库操作，FMDB要使用SQL语言
    //coreData是苹果封装，对数据库进行操作；coreData不需要使用SQL语言
    
    NSLog(@"%@",[NSHomeDirectory() stringByAppendingString:@"/Documents"]);
}

-(NSManagedObjectContext *)context{

    if (_context == nil) {
        
        AppDelegate *app = (id)[UIApplication sharedApplication].delegate;
        
        _context = app.managedObjectContext;
    }
    return _context;
}

- (IBAction)insertDataBtn:(UIButton *)sender {
    
    //参数一：模型名称
    //参数二：上下文操作context
    //StudentInfo：返回增加的模型对象
    StudentInfo *stu = [NSEntityDescription insertNewObjectForEntityForName:@"StudentInfo" inManagedObjectContext:self.context];
    
//    stu.name = [NSString stringWithFormat:@"张三%d",arc4random_uniform(100)];
//    stu.age = @(arc4random_uniform(100));
    
    NSDictionary *dic = @{@"name":[NSString stringWithFormat:@"张三%d",arc4random_uniform(100)],@"age":@(arc4random_uniform(100)),@"heighe":@"176"};
    
    [stu setValuesForKeysWithDictionary:dic];
    
    //context保存
    [self.context save:nil];
}

- (IBAction)deleteDataBtn:(UIButton *)sender {
    
    //先查找
    NSArray *arr = [self fetchData];
    
    //再删除
    [self.context deleteObject:arr[0]];
    
    //保存
    [self.context save:nil];
}

- (IBAction)searchDataBtn:(UIButton *)sender {
    
    //查找
    NSArray *arr = [self fetchData];
    
    for (StudentInfo *stu in arr) {
        
        NSLog(@"name = %@ --- age = %@",stu.name,stu.age);
    }
}

- (IBAction)updateDataBtn:(UIButton *)sender {
    
    //先查找
    NSArray *arr = [self fetchData];
    
    //再修改数据
    StudentInfo *stu = arr[0];
    stu.name = [NSString stringWithFormat:@"李四%d",arc4random_uniform(100)];
    stu.age = @(arc4random_uniform(100));
    
    //保存
    [self.context save:nil];
}

-(NSArray *)fetchData{

    //查找对象
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    
    //描述查找那个模型的信息
    //参数一：模型名称
    //参数二：context上下文
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StudentInfo" inManagedObjectContext:self.context];
    
    //设置entityDescription
    req.entity = entity;
    
    //排序描述类
    //参数一：按照哪个key排序
    //参数二：升序还是降序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    
    req.sortDescriptors = @[sort];
    
#if 0
    //谓词：查找的条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"age < 18 && name = '张三28'"];
    
    //设置谓词查找的条件
    req.predicate = pre;
#endif
    
    NSArray *arr = [self.context executeFetchRequest:req error:nil];
    
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
