//
//  ViewController.m
//  1-FMDBDemo
//
//  Created by mac on 16/6/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@property(nonatomic,strong)FMDatabase *dataBase;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建数据库文件
    //数据库文件的路径
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/dataBase.sqlite3"];
    
    NSLog(@"path = %@",path);
    
    //通过文件路径创建一个数据库
    self.dataBase = [[FMDatabase alloc] initWithPath:path];
    
    //打开数据库
    [self.dataBase open];
    
    //执行SQL语句：text是字符串类型，blob是二进制类型(NSData)
    BOOL ret = [self.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS Stuinfo (name text NOT NULL,age integer NOT NULL,image blob NOT NULL);"];
    
    if (ret) {
        
        NSLog(@"创建表OK");
    }
    
    //关闭数据库
    [self.dataBase close];
}

- (IBAction)insertDataBtn:(id)sender {
    
    [self.dataBase open];
    
    NSString *name = [NSString stringWithFormat:@"张三%d",arc4random_uniform(100)];
    NSNumber *num = [NSNumber numberWithInt:arc4random_uniform(100)];
    UIImage *img = [UIImage imageNamed:@"lcw.jpg"];
    NSData *data = UIImageJPEGRepresentation(img, 0.3);
    
    //执行SQL语句增加数据
    BOOL ret = [self.dataBase executeUpdate:@"INSERT INTO Stuinfo (name, age, image) VALUES (?, ?, ?)", name, num, data];
    
    if (ret) {
        
        NSLog(@"增加数据OK");
    }
    
    [self.dataBase close];
}

- (IBAction)deleteDataBtn:(id)sender {
    
    [self.dataBase open];
    
    BOOL ret = [self.dataBase executeUpdate:@"DELETE FROM Stuinfo"];
    
    if (ret) {
        
        NSLog(@"删除数据OK");
    }
    
    [self.dataBase close];
}

- (IBAction)searchDataBtn:(id)sender {
    
    [self.dataBase open];
    
    //所有查找的结果在FMResultSet对象里
    FMResultSet *set = [self.dataBase executeQuery:@"SELECT * FROM Stuinfo order BY age ASC"];
    
    //调用方法就是获取下一条数据
    while ([set next] == YES) {
        
        NSString *name = [set stringForColumn:@"name"];
        NSInteger age = [set intForColumn:@"age"];
        NSData *data = [set dataForColumn:@"image"];
        
        NSLog(@"name = %@ --- age = %ld",name,age);
        
        self.imgView.image = [UIImage imageWithData:data];
    }
    
    [self.dataBase close];
}

- (IBAction)updateDataBtn:(id)sender {
    
    [self.dataBase open];
    
    BOOL ret = [self.dataBase executeUpdate:@"UPDATE Stuinfo set name = ? WHERE name = ?",@"李四",@"张三5"];
    
    if (ret) {
        
        NSLog(@"修改数据OK");
    }
    
    [self.dataBase close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
