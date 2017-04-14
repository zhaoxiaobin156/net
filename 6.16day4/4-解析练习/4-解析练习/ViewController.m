//
//  ViewController.m
//  4-解析练习
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "MovieModel.h"
#import "AFNetworking.h"
#define MovieURL @"http://api.douban.com/v2/movie/us_box?apikey=02970273f8e1e22a07c5075beaa5a67e"

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:MovieURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"subjects"]) {
            
            MovieModel *mod = [[MovieModel alloc] initWithDictionary:dic error:nil];
            
            [self.dataSource addObject:mod];
        }
    
        for (MovieModel *mod in self.dataSource) {
            
            NSLog(@"%@", mod);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
            
}

-(NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
