//
//  NewsCollectionViewCell.m
//  NetEase News
//
//  Created by 许世强 on 2017/3/10.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import "NewsCollectionViewCell.h"
#import "NewsTableViewController.h"

@implementation NewsCollectionViewCell
{
    NewsTableViewController *_newVc;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    //创建新闻列表控制器
    _newVc = [[NewsTableViewController alloc] init];
    
    //注意:是将控制器的tableView添加在cell的contentView上
    [self.contentView addSubview:_newVc.tableView];
    
    //设置约束
    _newVc.tableView.frame = self.contentView.bounds;
    
    
}

- (void)setUrl:(NSString *)url{
    _url = url;
    
    _newVc.urlForTableView = url;
}

@end
