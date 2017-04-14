//
//  ViewController.m
//  3-label
//
//  Created by mac on 16/6/17.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//如果label的宽高没有用AutoLayout，那么label的宽高会根据label的文字自适应大小
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
}

-(void)updateTimer:(NSTimer *)timer{

    self.label.text = [self.label.text stringByAppendingString:@" label"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
