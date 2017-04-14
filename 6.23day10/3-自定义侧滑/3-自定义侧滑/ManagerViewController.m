//
//  ManagerViewController.m
//  3-自定义侧滑
//
//  Created by mac on 16/6/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ManagerViewController.h"

@interface ManagerViewController ()

@property(nonatomic,strong)UIViewController *leftVC;

@property(nonatomic,strong)UIViewController *rightVC;

@end

@implementation ManagerViewController

-(instancetype)initWithLeft:(UIViewController *)leftVC andRight:(UIViewController *)rightVC{

    if (self = [super init]) {
        
        self.leftVC = leftVC;
        self.rightVC = rightVC;
        
        self.leftVC.view.frame = CGRectMake(-100, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.rightVC.view.frame = [UIScreen mainScreen].bounds;
        
        //父控制器添加子控制器流程：
        //1.父控制器添加子控制器
        [self addChildViewController:self.leftVC];
        
        //2.父控制器的view添加子控制器的view
        [self.view addSubview:self.leftVC.view];
        
        //3.子控制器确定添加到父控制器
        [self.leftVC didMoveToParentViewController:self];
        
        [self addChildViewController:self.rightVC];
        [self.view addSubview:self.rightVC.view];
        [self.rightVC didMoveToParentViewController:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(clickItem:)];
}

-(void)clickItem:(UIBarButtonItem *)item{

    if (self.rightVC.view.frame.origin.x == 0) {
        
        CGRect rect = self.rightVC.view.frame;
        rect.origin.x = 150;
        
        [UIView animateWithDuration:3.25 animations:^{
            
            self.rightVC.view.frame = rect;
            
            self.leftVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }];
    }else{
    
        CGRect rect = self.rightVC.view.frame;
        rect.origin.x = 0;
        
        [UIView animateWithDuration:3.25 animations:^{
            
            self.rightVC.view.frame = rect;
            
            self.leftVC.view.frame = CGRectMake(-100, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }];
    }
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
