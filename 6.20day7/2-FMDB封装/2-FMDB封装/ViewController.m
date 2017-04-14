//
//  ViewController.m
//  2-FMDB封装
//
//  Created by mac on 16/6/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseManager.h"
#import "Person.h"
#import "PersonCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //常见单例
//    [NSUserDefaults standardUserDefaults]
//    [NSNotificationCenter defaultCenter]
//    [NSFileManager defaultManager]
//    [UIScreen mainScreen]
    
//    DataBaseManager *m = [DataBaseManager shareManager];
//    DataBaseManager *m2 = [DataBaseManager shareManager];
//    DataBaseManager *m3 = [DataBaseManager shareManager];
//    DataBaseManager *m4 = [[DataBaseManager alloc] init];
//    
//    NSLog(@"%p",m);
//    NSLog(@"%p",m2);
//    NSLog(@"%p",m3);
//    NSLog(@"%p",m4);
    
#if 0
    Person *per = [[Person alloc] init];
    per.name = @"张三";
    per.age = @"10";
    
    //增加数据
    [[DataBaseManager shareManager] insertData:per];
    
    //查找数据
    NSArray *arr = [[DataBaseManager shareManager] searchAllData];
    
    for (Person *per in arr) {
        
        NSLog(@"name = %@ --- age = %@",per.name,per.age);
    }
    
    Person *per2 = [[Person alloc] init];
    per2.age = @"100";
    
    //修改数据
    [[DataBaseManager shareManager] updateData:per2 WithName:@"张三"];
    
    //查找数据
    arr = [[DataBaseManager shareManager] searchAllData];
    
    for (Person *per in arr) {
        
        NSLog(@"name = %@ --- age = %@",per.name,per.age);
    }
    
    //删除数据
    [[DataBaseManager shareManager] deleteDataWithName:@"张三"];
#endif
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:[[DataBaseManager shareManager] searchAllData]];
    
    [self.tableView reloadData];
}

-(NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark --- UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Person *per = self.dataSource[indexPath.row];
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Images/%@.jpg",per.name];
    cell.imgView.image = [UIImage imageWithContentsOfFile:path];
    cell.nameL.text = per.name;
    cell.ageL.text = per.age;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
