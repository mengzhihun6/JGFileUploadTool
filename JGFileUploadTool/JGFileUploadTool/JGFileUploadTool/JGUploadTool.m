//
//  JGUploadTool.m
//  分片上传
//
//  Created by 郭军 on 2019/7/18.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import "JGUploadTool.h"
#import "JGFileStreamOperation.h"

@interface JGUploadTool()

@property(strong,nonatomic) JGFileStreamOperation *fileStreamer;
@property(assign,nonatomic) NSInteger currentIndex;
@property(nonatomic,strong)NSThread *thread1;
@property(nonatomic,strong)NSThread *thread2;
@property(nonatomic,strong)NSThread *thread3;
@property(strong,nonatomic) NSDate *date1;
@end


@implementation JGUploadTool

-(void)upDataWithPath:(NSString *)path{
    
    JGFileStreamOperation *fileStreamer = [[JGFileStreamOperation alloc] initFileOperationAtPath:path forReadOperation:YES];
    self.fileStreamer = fileStreamer;
    self.currentIndex = 0;
    [self toUpData];
}

#pragma mark  懒加载
-(NSThread *)thread1{
    if (!_thread1) {
        _thread1=[[NSThread alloc]initWithTarget:self selector:@selector(upOne) object:nil];
    }
    return _thread1;
}
-(NSThread *)thread2{
    if (!_thread2) {
        _thread2=[[NSThread alloc]initWithTarget:self selector:@selector(upOne) object:nil];
    }
    return _thread2;
}
-(NSThread *)thread3{
    if (!_thread3) {
        _thread3=[[NSThread alloc]initWithTarget:self selector:@selector(upOne) object:nil];
    }
    return _thread3;
}


#pragma mark  方法

-(void)toUpData{
    self.date1 = [NSDate date];
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
    
}


-(void)upOne{
    while (1) {
        //        线程安全,防止多次上传同一块区间
        @synchronized (self) {
            @autoreleasepool {
                if (self.currentIndex < self.fileStreamer.fileFragments.count - 1) {
                    

                    if (self.fileStreamer.fileFragments[self.currentIndex].fragmentStatus == FileUpStateWaiting) {
                        self.fileStreamer.fileFragments[self.currentIndex].fragmentStatus = FileUpStateLoading;
                        NSData *data = [self.fileStreamer readDateOfFragment:self.fileStreamer.fileFragments[self.currentIndex]];
                        //                在这里执行上传的操作
                        
                        NSLog(@"需要上传的数据%@", data);
                        sleep(arc4random() % 3);
                        NSLog(@"共%ld个片段，这是第%zd个上传----%@",  self.fileStreamer.fileFragments.count, self.currentIndex + 1,[NSThread currentThread]);
                        self.currentIndex++;
                    }
                    
                } else {
                    NSLog(@"时间间隔是%d",(int)[[NSDate date] timeIntervalSinceDate:self.date1]);
                    [NSThread exit];
                    
                }
            }
        }
    }
    
}



@end
