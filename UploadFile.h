//
//  UploadFile.h
//  线程
//
//  Created by comyn on 2018/3/5.
//  Copyright © 2018年 comyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadFile : NSObject


/**
 上传单个文件，不带参数

 @param urlString 上传url
 @param fileName 上传的控件名
 @param filePath 上传的文件名
 */
+ (void)uploadFile:(NSString *)urlString fileName:(NSString *)fileName filePath:(NSString *)filePath;

/**
 上传单个文件，带参数
 
 @param urlString 上传url
 @param fileName 上传的控件名
 @param filePath 上传的文件名
 */
+ (void)uploadFile:(NSString *)urlString fileName:(NSString *)fileName filePath:(NSString *)filePath params:(NSDictionary *)params;

/**
 上传多个文件，带参数
 
 @param urlString 上传url
 @param fileName 上传的控件名
 @param filePaths 上传的多个文件名
 */
+ (void)uploadFile:(NSString *)urlString fileName:(NSString *)fileName filePaths:(NSArray *)filePaths params:(NSDictionary *)params;
@end
