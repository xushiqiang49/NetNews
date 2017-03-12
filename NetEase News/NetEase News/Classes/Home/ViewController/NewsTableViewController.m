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
#import "NewsTableViewCell.h"

@interface NewsTableViewController ()

@property(nonatomic,strong)NSArray *array;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupTableView];
}
//  tableView的相关设置
- (void)setupTableView {
    
    //  注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseCell" bundle:nil] forCellReuseIdentifier:@"baseCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BigImageCell" bundle:nil] forCellReuseIdentifier:@"bigImageCell"];

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

    NewsTableViewCell *cell ;

   NewsModel *model = self.array[indexPath.row];

    if (model.imgType) {
        
        //有大图标记
        cell = [tableView dequeueReusableCellWithIdentifier:@"bigImageCell" forIndexPath:indexPath];
    
    }else{
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell" forIndexPath:indexPath];
    }
    
    cell.newsModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = self.array[indexPath.row];
    
    if (model.imgType) {
        
        return 130;
    } else{
        
        return 80;
    }
}
@end
