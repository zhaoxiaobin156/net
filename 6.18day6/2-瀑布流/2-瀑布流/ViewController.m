//
//  ViewController.m
//  2-瀑布流
//
//  Created by mac on 16/6/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CatCell.h"
#import "AFNetworking.h"
#import "FashionCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CHTCollectionViewDelegateWaterfallLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,strong)NSMutableArray *fashionDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    //设置瀑布流列数
    layout.columnCount = 2;
    
    //列的间距
    layout.minimumColumnSpacing = 10;
    
    //行的间距
    layout.minimumInteritemSpacing = 10;
    
    //每一段上左下右的间距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CatCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FashionCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    
    [self fetchDataFromServer];
}

-(void)fetchDataFromServer{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://api2.hichao.com/stars?category=%E6%9C%80%E6%96%B0&pin=189992&ga=%2Fstars&flag=&gv=633&access_token=&gi=352284049051703&gos=6.3.3&gsv=4.4.2&p=NoxW&gc=tengxun&gn=mxyc_adr&gs=720x1242&gf=android&lts=1446440885" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"data"][@"items"]) {
            
            FashionModel *mod = [[FashionModel alloc] initWithDictionary:dic error:nil];
            
            [self.fashionDataSource addObject:mod];
        }
        
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
        
        for (int i = 0; i < 50; i++) {
            
            [_dataSource addObject:[NSString stringWithFormat:@"cat%d.jpg",arc4random_uniform(4) + 1]];
        }
    }
    return _dataSource;
}

-(NSMutableArray *)fashionDataSource{

    if (_fashionDataSource == nil) {
        _fashionDataSource = [NSMutableArray array];
    }
    return _fashionDataSource;
}

#pragma mark --- UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    NSInteger count = 0;
    
    if (self.dataSource.count != 0) {
        
        count++;
    }
    if (self.fashionDataSource.count != 0) {
        
        count++;
    }
    return count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        
        return self.dataSource.count;
    }else{
        
        return self.fashionDataSource.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        CatCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.imgView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
        
        return cell;
    }else{
        
        FashionCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        
        FashionModel *mod = self.fashionDataSource[indexPath.row];
        
        [cell2 refreshUI:mod];
        
        return cell2;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        UIImage *image = [UIImage imageNamed:self.dataSource[indexPath.row]];
        
        //宽高比例
        CGFloat p = image.size.width / image.size.height;
        
        //cell宽度
        CGFloat w = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
        
        return CGSizeMake(w, w / p);
    }else{
    
        FashionModel *mod = self.fashionDataSource[indexPath.row];
        
        CGFloat w = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
        
        CGFloat h = mod.height.floatValue / mod.width.floatValue * w + 46;
        
        return CGSizeMake(w, h);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
