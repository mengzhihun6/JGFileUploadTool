//
//  ViewController.m
//  JGFileUploadTool
//
//  Created by 郭军 on 2019/9/24.
//  Copyright © 2019 JG. All rights reserved.
//

#import "ViewController.h"
#import "JGUploadTool.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)UpLoadFMDBData:(id)sender {
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
//                                                         , NSUserDomainMask
//                                                         , YES);
//    NSString *path = [NSString stringWithFormat:@"%@/FMDB.db",paths.firstObject];

   NSString *path =   [[NSBundle mainBundle] pathForResource:@"FMDB" ofType:@"db"];
    
    NSLog(@"path = %@",path);
    
    [[JGUploadTool new]upDataWithPath:path];
    
}



- (IBAction)btnClick:(UIButton *)sender {
    UIImagePickerController *pic = [[UIImagePickerController alloc]init];
    pic.delegate = self;
    pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    pic.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [self presentViewController:pic animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"path = %@",[url path]);

        
        [[JGUploadTool new] upDataWithPath:[url path]];
        
    }];
    
    
}




@end
