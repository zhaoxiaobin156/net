//
//  SecondViewController.m
//  2-FMDB封装
//
//  Created by mac on 16/6/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import "DataBaseManager.h"

@interface SecondViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameT;

@property (weak, nonatomic) IBOutlet UITextField *ageT;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnClick:(UIButton *)sender {
    
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    pickerVC.delegate = self;
    
    pickerVC.allowsEditing = YES;
    
    [self presentViewController:pickerVC animated:YES completion:nil];
}

#pragma mark --- 相册控制器的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.imgView.image = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addItem:(UIBarButtonItem *)sender {
    
    Person *per = [[Person alloc] init];
    per.name = self.nameT.text;
    per.age = self.ageT.text;
    [[DataBaseManager shareManager] insertData:per];
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/Images"];
    
    NSLog(@"path = %@", path);
    
    //如果Images文件夹不存在，则创建该文件夹
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
 
    NSString *imgPath = [path stringByAppendingFormat:@"/%@.jpg", per.name];

    NSData *data = UIImageJPEGRepresentation(self.imgView.image, 0.4);
    
    [[NSFileManager defaultManager] createFileAtPath:imgPath contents:data attributes:nil];

    [self.navigationController popViewControllerAnimated:YES];
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
