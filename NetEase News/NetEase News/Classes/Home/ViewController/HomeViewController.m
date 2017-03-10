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
#import "TagLabel.h"
#import "NewsCollectionViewCell.h"
#import "NetWorkTools.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)NSArray<TagModel *> *tagModelArray;

//频道标签视图
@property (weak, nonatomic) IBOutlet UIScrollView *tagScrollView;

//新闻视图
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;

//item的布局属性
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *NewCollectionViewFlowOut;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tagModelArray = [NSArray array];
    
    //iOS 7 ,滚动视图向下默认偏移74
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setTageScrollView];
    
    [self setNewCollectionView];
}

#pragma mark -- 02 设置新闻滚动视图
- (void)setNewCollectionView{
    
    //设置代理
    self.newsCollectionView.dataSource = self;
    
    self.newsCollectionView.delegate = self;
    
    //设置item的大小
    self.NewCollectionViewFlowOut.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - self.tagScrollView.frame.size.width - 64);

    //设置垂直间距
    self.NewCollectionViewFlowOut.minimumLineSpacing = 0;
    
    //设置水平间距
    self.NewCollectionViewFlowOut.minimumInteritemSpacing = 0;
    
    //滚动方向
    self.NewCollectionViewFlowOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //开启分页
    self.newsCollectionView.pagingEnabled = YES;
    
    //去掉弹簧
    self.newsCollectionView.bounces = NO;
    
    //去掉滚动条
    self.newsCollectionView.showsHorizontalScrollIndicator = NO;
    self.newsCollectionView.showsVerticalScrollIndicator = NO;
    
    //预加载
    self.newsCollectionView.prefetchingEnabled = YES;
    
    //单例   block的回调
    [[NetWorkTools sharedTools] requestWithType:GET andUrlStr:@"T1348647853363/0-20.html" andParameter:nil andSucess:^(id responseObject) {
        
        
        
    } andFailure:^(id error) {
       
        
        
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.tagModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsCell" forIndexPath:indexPath];
    
    //获取频道的id
    NSString *tid = self.tagModelArray[indexPath.item].tid;
    
    //拼接请求的当前url
    NSString *urlNowStr = [NSString stringWithFormat:@"%@/0-20.html",tid];
    
    cell.url = urlNowStr;
    
    return cell;
}

#pragma mark -- 01 设置频道标签视图
- (void)setTageScrollView{
    
   self.tagModelArray = [TagModel getTagModelArray];
    
    //创建标签的label
    CGFloat tagLabelWidth = 80;
    CGFloat tagLabelHeight = 44;
    
    for (int i = 0; i < self.tagModelArray.count; i++) {
        
        TagLabel *label = [[TagLabel alloc] initWithFrame:CGRectMake(tagLabelWidth *i, 0, tagLabelWidth, tagLabelHeight)];;
        
        label.text = self.tagModelArray[i].tname;
        
        label.font = [UIFont systemFontOfSize:15];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self.tagScrollView addSubview:label];
        
        //设置contentSize
        self.tagScrollView.contentSize = CGSizeMake(tagLabelWidth * self.tagModelArray.count, 0);
        
        self.tagScrollView.showsHorizontalScrollIndicator = NO;
        self.tagScrollView.showsVerticalScrollIndicator = NO;
        
    }
    
}




@end
