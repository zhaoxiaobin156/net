//
//  GGView.m
//  
//
//  Created by lgh on 16/6/15.
//
//

#import "GGView.h"
#import "GGCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface GGView ()  <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation GGView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        self.collectionView.pagingEnabled = YES;
        self.collectionView.bounces = NO;
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"GGCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        [self addSubview:self.collectionView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30)];
        
        //设置背景颜色的透明度
        self.pageControl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];

        self.pageControl.pageIndicatorTintColor = [UIColor redColor];

        [self addSubview:self.pageControl];
    }
    return self;
}

#pragma mark - collectionViewCell的代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSLog(@"%p", cell);//复用cell
    
    if (indexPath.item == 0) {
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[self.dataSource.count - 1]]];
        
    }else if (indexPath.item == self.dataSource.count + 1){
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[0]]];
    }else{
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.item - 1]]];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.bounds.size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    self.block(indexPath.item);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        
        scrollView.contentOffset = CGPointMake(self.dataSource.count * self.bounds.size.width, 0);
        
    }else if (scrollView.contentOffset.x / self.bounds.size.width == (self.dataSource.count + 1)){
        
        scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }
    
    self.pageControl.currentPage = scrollView.contentOffset.x / self.bounds.size.width - 1;
}
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    
    [self.collectionView reloadData];
    
    [self.collectionView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    
    self.pageControl.numberOfPages = self.dataSource.count;
}

@end














