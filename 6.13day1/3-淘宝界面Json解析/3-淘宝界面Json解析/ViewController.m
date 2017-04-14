//
//  ViewController.m
//  3-淘宝界面Json解析
//
//  Created by mac on 16/6/13.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "TaoBaoCell.h"
#import "UIViewController+AlertShow.h"
#define TaoBaoURL @"http://1000phone.net:8088/app/taobao/api/get_list.php?cate_id=2729"

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self fetchDataFromServer];
}

-(void)fetchDataFromServer{
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:TaoBaoURL]];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError != nil) {
            
            NSLog(@"错误信息 = %@",connectionError);
            
            [self showAlertWithTitle:@"温馨提示" andMessage:@"请检查网络"];
        }else{
            
            //Json解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary *d in dic[@"List"]) {
                
                TaoBaoModel *mod = [[TaoBaoModel alloc] init];
                mod.img = d[@"img"];
                mod.name = d[@"name"];
                mod.nick = d[@"nick"];
                mod.price = d[@"price"];
                
                [self.dataSource addObject:mod];
                
//                for (TaoBaoModel *mod in self.dataSource) {
//                    
//                    NSLog(@"%@---%@---%@---%@",mod.img,mod.name,mod.nick,mod.price);
//                }
                
                //刷新UI界面
                [self.tableView reloadData];
            }
        }
    }];
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

    TaoBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    TaoBaoModel *mod = self.dataSource[indexPath.row];
    
    [cell refreshUI:mod];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //闪烁效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showAlertWithTitle:@"温馨提示" andMessage:@"敬请期待"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
