//
//  DetailViewController.h
//  
//
//  Created by lgh on 16/4/5.
//
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) HomeModel *homeModel; //!< 主页传递给详情界面的模型;


@end
