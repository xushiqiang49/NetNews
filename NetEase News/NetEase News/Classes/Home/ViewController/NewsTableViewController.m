//
//  NewsTableViewController.m
//  NetEase News
//
//  Created by 许世强 on 2017/3/10.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import "NewsTableViewController.h"

@interface NewsTableViewController ()

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 重写seturl方法
- (void)setUrlForTableView:(NSString *)urlForTableView{
    
    _urlForTableView = urlForTableView;
    
    //单例   block的回调
    [[NetWorkTools sharedTools] requestWithType:GET andUrlStr:urlForTableView andParameter:nil andSucess:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSString *key = dict.allKeys.firstObject;
        
        NSArray *newsArray = [dict objectForKey:key];
        
    } andFailure:^(id error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


@end
