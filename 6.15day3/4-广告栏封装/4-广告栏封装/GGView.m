//
//  GGView.m
//  4-广告栏封装
//
//  Created by mac on 16/6/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "GGView.h"
#import "GGCollectionViewCell.h"

@interface GGView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation GGView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        self.collectionView.pagingEnabled = YES;
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"GGCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)setDataSource:(NSArray *)dataSource{

    _dataSource = dataSource;
    
    [self.collectionView reloadData];
}

#pragma mark --- UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    GGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imgView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return self.collectionView.bounds.size;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
