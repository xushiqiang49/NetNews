//
//  NewsModel.m
//  NetEase News
//
//  Created by 许世强 on 2017/3/11.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import "NewsModel.h"
#import "NetWorkTools.h"
#import <YYModel.h>

@implementation NewsModel

+ (void)requestNewsModelArrayWithUrlStr:(NSString *)urlStr andCompletionBlock:(void(^)(NSArray * modelArray)) completionBlock{
    
[[NetWorkTools sharedTools] requestWithType:GET andUrlStr:urlStr andParameter:nil andSucess:^(id responseObject) {
    
    NSDictionary *dict = (NSDictionary *)responseObject;
    
    NSString *key = dict.allKeys.firstObject;
    
    NSArray *newsArray = [dict objectForKey:key];
    
    NSArray *modelArray = [NSArray yy_modelArrayWithClass:[NewsModel class] json:newsArray];
    
    completionBlock(modelArray);
    
} andFailure:^(id error) {
    
}];
}
@end
