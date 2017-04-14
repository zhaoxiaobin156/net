//
//  ViewController.m
//  1-代码里修改约束
//
//  Created by mac on 16/6/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnBottomConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardWillShow:(NSNotification *)noti{
    
    CGFloat height = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.btnBottomConstraint.constant = 47 + height;
        
        //为了让约束有动画效果
        [self.view layoutIfNeeded];
        
    } completion:nil];
}

-(void)keyboardWillHidden:(NSNotification *)noti{

    [UIView animateWithDuration:0.25 animations:^{
        
        self.btnBottomConstraint.constant = 47;
        
        [self.view layoutIfNeeded];
        
    } completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

@end
