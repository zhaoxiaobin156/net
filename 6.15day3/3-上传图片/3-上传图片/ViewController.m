//
//  ViewController.m
//  3-上传图片
//
//  Created by mac on 16/6/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)login:(UIButton *)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:@"http://10.0.8.8/sns/my/login.php" parameters:@{@"username":@"ios2449608306",@"password":@"123456"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject[@"message"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息 = %@",error);
        
    }];
}

- (IBAction)uploadImg:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //上传非文本文件
    [manager POST:@"http://10.0.8.8/sns/my/upload_headimage.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //在第一个block里面拼接上传非文本的数据
        //获取上传的图片
        UIImage *img = [UIImage imageNamed:@"14.jpg"];
        
        NSData *data = UIImageJPEGRepresentation(img, 0.1);
        
        //参数一：需要上传的图片数据
        //参数二：服务器对应的图片字段
        //参数三：文件名称
        //参数四：文件类型
        [formData appendPartWithFileData:data name:@"headimage" fileName:@"14.jpg" mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject[@"message"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息 = %@",error);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
