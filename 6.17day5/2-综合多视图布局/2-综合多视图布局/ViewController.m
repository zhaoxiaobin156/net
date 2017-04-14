//
//  ViewController.m
//  2-综合多视图布局
//
//  Created by mac on 16/6/17.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //如果让Autolayout自动计算cell高度，要加以下代码：
    //1.预计高度
    self.tableView.estimatedRowHeight = 100;
    
    //2.设置行高为自动计算
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

-(NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
        
        for (int i = 0; i < 30; i++) {
            
            NSMutableString *mutStr = [NSMutableString string];
            
            for (int j = 0; j < arc4random() % 60; j++) {
                
                [mutStr appendString:@"这是一个内容文字 "];
            }
            [_dataSource addObject:mutStr];
        }
    }
    return _dataSource;
}

#pragma mark --- UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.contentL.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
