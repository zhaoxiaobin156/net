//
//  CollectViewController.m
//  iLimitFree
//
//  Created by mac on 16/6/30.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectCell.h"

@interface CollectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation CollectViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    [self getDataFromDB];
}

-(void)getDataFromDB{

    //读取之前清空
    [self.dataSource removeAllObjects];

    //把数据库中的数据加入数据源
    [self.dataSource addObjectsFromArray:[[SQLManager shareInstance] getCollectData]];
    
    //刷新界面
    [self.collectionView reloadData];
}

#pragma mark --- UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectCell" forIndexPath:indexPath];
    
    CollectModel *mod = self.dataSource[indexPath.row];
    cell.imgView.image = mod.image;
    cell.nameLabel.text = mod.name;
    
    [cell.deleteBtn addTarget:self action:@selector(deleteApp:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = 100 + indexPath.row;
    
    return cell;
}

-(void)deleteApp:(UIButton *)btn{

    //通过tag获取到点击的模型
    CollectModel *mod = self.dataSource[btn.tag - 100];
    
    //删除分两部分：
    
    //1.删除数据库中的数据
    [[SQLManager shareInstance] deleteCollectWith:mod.applicationId];
    
    //2.删除界面中数据源中的数据
    [self.dataSource removeObject:mod];
    
    //刷新界面
    [self.collectionView reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectModel *mod = self.dataSource[indexPath.row];
    
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    
    detailVC.applicationId = mod.applicationId;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
