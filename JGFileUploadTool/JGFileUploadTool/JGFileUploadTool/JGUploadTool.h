//
//  JGUploadTool.h
//  分片上传
//
//  Created by 郭军 on 2019/7/18.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGUploadTool : NSObject

/**
 根据路径上传本地文件

 @param path 文件所在的本地路径
 */
-(void)upDataWithPath:(NSString *)path;

@end
