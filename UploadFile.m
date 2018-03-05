//
//  UploadFile.m
//  线程
//
//  Created by comyn on 2018/3/5.
//  Copyright © 2018年 comyn. All rights reserved.
//

#import "UploadFile.h"

#define kBOUNDARY @"abc" //自定义分隔符

@implementation UploadFile

+ (void)uploadFile:(NSString *)urlString fileName:(NSString *)fileName filePath:(NSString *)filePath {
    [self uploadFile:urlString fileName:fileName filePath:filePath params:nil];
}

+ (void)uploadFile:(NSString *)urlString fileName:(NSString *)fileName filePath:(NSString *)filePath params:(NSDictionary *)params {
    [self uploadFile:urlString fileName:filePath filePaths:@[filePath] params:params];
}

+ (void)uploadFile:(NSString *)urlString fileName:(NSString *)fileName filePaths:(NSArray *)filePaths params:(NSDictionary *)params {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"post";
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBOUNDARY] forHTTPHeaderField:@"Content-Type"];
    
    request.HTTPBody = [self makeHttpBody:fileName filePaths:filePaths params:params];
    
    [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
}

+ (NSData *)makeHttpBody:(NSString *)fileName filePaths:(NSArray *)filePaths params:(NSDictionary *)params {
    NSMutableData *mData = [NSMutableData data];
    
    [filePaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableString *mString = [NSMutableString string];
        if (idx == 0) {
            [mString appendFormat:@"--%@\r\n",kBOUNDARY];
        }else{
            [mString appendFormat:@"\r\n--%@\r\n",kBOUNDARY];
        }
        [mString appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fileName, [obj lastPathComponent]];
        [mString appendString:@"Content-Type: application/octet-stream\r\n"];
        [mString appendString:@"\r\n"];
        
        [mData appendData:[mString dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSData dataWithContentsOfFile:obj];
        [mData appendData:data];
    }];
    
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableString *mString = [NSMutableString string];
        [mString appendFormat:@"\r\n--%@\r\n",kBOUNDARY];
        [mString appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n",key];
        [mString appendString:@"\r\n"];
        [mString appendFormat:@"%@",obj];
        
        [mData appendData:[mString dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    NSString *end = [NSString stringWithFormat:@"\r\n--%@--",kBOUNDARY];
    [mData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    return mData.copy;
}

@end
