//
//  FashionCell.h
//  2-瀑布流
//
//  Created by mac on 16/6/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FashionModel.h"

@interface FashionCell : UICollectionViewCell

-(void)refreshUI:(FashionModel *)mod;

@end
