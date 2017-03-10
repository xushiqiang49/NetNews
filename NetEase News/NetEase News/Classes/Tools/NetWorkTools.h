//
//  NetWorkTools.h
//  NetEase News
//
//  Created by 许世强 on 2017/3/10.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum: NSUInteger{
    GET,
    POST
}RequestType;

@interface NetWorkTools : AFHTTPSessionManager

//创建单例
+ (instancetype)sharedTools;

- (void)requestWithType:(RequestType)requesType andUrlStr:(NSString *) url andParameter:(id) parameter andSucess:(void(^)(id responseObject))sucessBlock andFailure:(void(^)(id error)) failureBloc;

@end


