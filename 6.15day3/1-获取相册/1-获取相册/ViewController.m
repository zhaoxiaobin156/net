//
//  ViewController.m
//  1-获取相册
//
//  Created by mac on 16/6/15.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tapClick:(UITapGestureRecognizer *)sender {
    
    //获取手机相册
    //手机相册是控制器(相册控制器)
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    
    //设置相册控制器的来源类型
//    UIImagePickerControllerSourceTypePhotoLibrary(相册库)
//    UIImagePickerControllerSourceTypeCamera(相机：只能在真机有效，模拟器会奔溃)
//    UIImagePickerControllerSourceTypeSavedPhotosAlbum(相册)
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //设置相册控制器的代理
    pickerVC.delegate = self;
    
    //设置相册是否允许编辑
    pickerVC.allowsEditing = YES;
    
    //弹出相册控制器
    [self presentViewController:pickerVC animated:YES completion:nil];
}

- (IBAction)saveImg:(UIButton *)sender {
    
    //参数一：保存的图片
    //参数二：target
    //参数三：@selector
    //参数四：NULL
    UIImageWriteToSavedPhotosAlbum([UIImage imageNamed:@"21_1.jpg"], self, @selector(saveSuccess:andError:andContext:), NULL);
}

#pragma mark --- 保存图片后调用的方法(参数必须是：UIImage,NSError,void *,方法名随意)

-(void)saveSuccess:(UIImage *)img andError:(NSError *)error andContext:(void *)context{
    
    if (error) {
        
        NSLog(@"错误信息 ＝ %@",error);
    }else{
        
        NSLog(@"保存成功");
    }

}

#pragma mark --- 相册控制器的代理方法

//选择图片后调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    //参数一：相册控制器
    //参数二：选择图片的信息
    NSLog(@"%@",info);
    
    //获取原始图片
    self.imgView.image = info[UIImagePickerControllerEditedImage];
    
    //压缩图片：img -> NSData
    //参数一：图片
    //参数二：压缩系数：0 ～ 1
    NSData *data = UIImageJPEGRepresentation(self.imgView.image, 0.0001);
    NSData *data2 = UIImageJPEGRepresentation(self.imgView.image, 0.8);
    
//    NSData *data3 = UIImagePNGRepresentation(self.imgView.image);
    
    //保存到沙盒
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/"];
    
    NSLog(@"path = %@",path);
    
    [[NSFileManager defaultManager] createFileAtPath:[path stringByAppendingString:@"1.jpg"] contents:data attributes:nil];
    [[NSFileManager defaultManager] createFileAtPath:[path stringByAppendingString:@"2.jpg"] contents:data2 attributes:nil];
    
    //退出相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
