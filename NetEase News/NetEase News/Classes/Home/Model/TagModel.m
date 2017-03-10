//
//  TagModel.m
//  NetEase News
//
//  Created by 许世强 on 2017/3/10.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel

- (NSString *)description{
    
    NSString *desc = [NSString stringWithFormat:@"%@ -- %@",self.tid,self.tname];
    
    return desc;
}

#pragma mark --  获取标签数据
+ (NSArray *)getTagModelArray{

    //获取路径
    NSString *tagPath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    
    //获取路径文件对应的json的二进制数据
    NSData *tagJsonData = [NSData dataWithContentsOfFile:tagPath];
    
    //反序列化二进制数据
    NSDictionary *tagDict = [NSJSONSerialization JSONObjectWithData:tagJsonData options:0 error:NULL];
    
    //根据打印结果,需要取出key(数据这里只提供了一个key)
    NSArray *tagArray = [tagDict objectForKey:@"tList"];
    
    //YYModle框架,数组转模型
    NSArray *tagModelArray = [NSArray yy_modelArrayWithClass:[TagModel class] json:tagArray];
    
    //标签是有序的,需要根据id进行排序
   tagModelArray =  [tagModelArray sortedArrayUsingComparator:^NSComparisonResult(TagModel *obj1, TagModel *obj2) {
       
       return [obj1.tid compare:obj2.tid];
    }];
    
    return tagModelArray;
    
}

@end
