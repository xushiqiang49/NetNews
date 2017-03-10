//
//  HomeViewController.m
//  NetEase News
//
//  Created by 许世强 on 2017/3/10.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import "HomeViewController.h"
#import "TagModel.h"
#import <YYModel.h>

@interface HomeViewController ()

@property(nonatomic, strong)NSArray *tagModelArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.tagModelArray = [NSArray array];
    
    [self loadTagData];
}

#pragma mark -- 01 获取本地的标签数据
- (void)loadTagData{
    
   self.tagModelArray = [TagModel getTagModelArray];
    
}


@end
