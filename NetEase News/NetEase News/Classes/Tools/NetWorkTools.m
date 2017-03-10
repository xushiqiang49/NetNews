//
//  NetWorkTools.m
//  NetEase News
//
//  Created by 许世强 on 2017/3/10.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import "NetWorkTools.h"

@implementation NetWorkTools

+ (instancetype)sharedTools{

    static NetWorkTools *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tools = [[NetWorkTools alloc] initWithBaseURL:[NSURL URLWithString:@"http://c.m.163.com/nc/article/list/"]];
    });
    
    return tools;
}

- (void)requestWithType:(RequestType)requesType andUrlStr:(NSString *) url andParameter:(id) parameter andSucess:(void(^)(id responseObject))sucessBlock andFailure:(void(^)(id error)) failureBlock{
    
    if(requesType == GET){
    
    [self GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        sucessBlock(responseObject);
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
   
    }];
        
    } else {
        
        [self POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            sucessBlock(responseObject);
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
       
        }];
    }
    
}
@end
