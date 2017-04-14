//
//  CollectionViewCell.h
//  
//
//  Created by lgh on 16/6/23.
//
//

#import <UIKit/UIKit.h>
#import "GGView.h" // 广告栏;

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet GGView *ggView;

@end
