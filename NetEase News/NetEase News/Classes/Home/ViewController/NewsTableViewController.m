//
//  NewsTableViewController.m
//  NetEase News
//
//  Created by 许世强 on 2017/3/10.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NetWorkTools.h"
#import "NewsModel.h"

@interface NewsTableViewController ()

@property(nonatomic,strong)NSArray *array;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 重写seturl方法
- (void)setUrlForTableView:(NSString *)urlForTableView{
    
    _urlForTableView = urlForTableView;
    
    [NewsModel requestNewsModelArrayWithUrlStr:urlForTableView andCompletionBlock:^(NSArray *modelArray) {
        
        _array = modelArray;
        
        [self.tableView reloadData];
    } ];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NewsModel *model = self.array[indexPath.row];
    //  显示新闻标题
    cell.textLabel.text = model.title;
    
    return cell;
}

@end
