//
//  CustomTabBarController.m
//  
//
//  Created by lgh on 16/4/6.
//
//

#import "CustomTabBarController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建四个控制器:
    UINavigationController *nvc1 = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    UINavigationController *nvc2 = [[UINavigationController alloc] initWithRootViewController:[[NewsViewController alloc] init]];
    UINavigationController *nvc3 = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    UINavigationController *nvc4 = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    
    self.viewControllers = @[nvc1, nvc2, nvc3, nvc4];
    
    NSArray *name = @[@"食谱", @"食课", @"喜欢", @"我的"];
    
    for (UINavigationController *nvc in self.viewControllers) {
        NSInteger index = [self.viewControllers indexOfObject:nvc];
        // 设置title:
        nvc.tabBarItem.title = name[index];
        
        nvc.tabBarItem.image = [[UIImage imageNamed:[name[index] stringByAppendingString:@"A"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        nvc.tabBarItem.selectedImage = [[UIImage imageNamed:[name[index] stringByAppendingString:@"B"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        
        // 设置图片偏移量:
        nvc.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
        [nvc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255 / 255.0 green:122 / 255.0 blue:68 / 255.0 alpha:1.0]} forState:UIControlStateSelected];
//        [nvc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    } // 255,122,68
    
    
}



@end













