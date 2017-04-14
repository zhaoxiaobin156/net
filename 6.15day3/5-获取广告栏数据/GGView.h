//
//  GGView.h
//  
//
//  Created by lgh on 16/6/15.
//
//

#import <UIKit/UIKit.h>
typedef void(^GGViewBlock)(NSInteger item);

@interface GGView : UIView

@property (nonatomic, strong) NSArray *dataSource; //!< 数据源

@property(nonatomic,copy)GGViewBlock block;

@end
