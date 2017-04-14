//
//  GGView.m
//  
//
//  Created by lgh on 16/6/15.
//
//

#import "GGView.h"
#import "GGCollectionViewCell.h"

@interface GGView ()  <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GGView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.bounds = self.bounds;
}

- (void)awakeFromNib
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];

    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GGCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self addSubview:self.collectionView];
    
    [super awakeFromNib];
}

#pragma mark --- collectionViewCell的代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.item]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.bounds.size;
}

#pragma mark --- Setter

- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    
    [self.collectionView reloadData];
}

@end














