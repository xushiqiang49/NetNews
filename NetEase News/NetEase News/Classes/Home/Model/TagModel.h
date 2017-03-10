//
//  TagModel.h
//  NetEase News
//
//  Created by 许世强 on 2017/3/10.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface TagModel : NSObject

@property(nonatomic, copy)NSString *tid;

@property(nonatomic, copy)NSString *tname;


+ (NSArray *)getTagModelArray;
@end
