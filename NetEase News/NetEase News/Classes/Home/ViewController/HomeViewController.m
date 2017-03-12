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
    
    //[self tapGesture];
}

#pragma mark -- 03 点击频道标签,要显示在居中位置
//点击频道标签的手势处理
- (void)tapChannelLabelAction:(UITapGestureRecognizer *)gesture{

    TagLabel *tagLabel = (TagLabel *)gesture.view;
    
    CGFloat tagLabeCenterX = tagLabel.center.x;
    
    CGFloat contentOffSetX = tagLabeCenterX - self.view.frame.size.width * 0.5;
    
    //设置最小滚动范围
    CGFloat contentOffSetMinX = 0;
    
    //最大滚动范围
    CGFloat contentOffSetMaxX = self.tagScrollView.contentSize.width - self.view.frame.size.width;
    
    //MARK: 对滚动范围进行判断,防止第一个和最后一个标签居中
    if (contentOffSetX < contentOffSetMinX) {
        
        contentOffSetX = contentOffSetMinX;
    }
    if (contentOffSetX > contentOffSetMaxX) {
        
        contentOffSetX = contentOffSetMaxX;
    }
    
    [self.tagScrollView setContentOffset:CGPointMake(contentOffSetX, 0) animated:YES];
    
}

#pragma mark -- 02 设置新闻滚动视图
- (void)setNewCollectionView{
    
    //设置代理
    self.newsCollectionView.dataSource = self;
    
    self.newsCollectionView.delegate = self;
    
    //设置item的大小
    self.NewCollectionViewFlowOut.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 44 - 64);

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
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
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
        
        //MARK:开启频道标签的用户交互,并创建手势
        label.userInteractionEnabled = YES;
        
        //创建手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChannelLabelAction:)];
        
        //添加手势
        [label addGestureRecognizer:tapGesture];
        
        //设置tag
        label.tag = i;
        
        
        //MARK:设置contentSize
        self.tagScrollView.contentSize = CGSizeMake(tagLabelWidth * self.tagModelArray.count, 0);
        
        self.tagScrollView.showsHorizontalScrollIndicator = NO;
        self.tagScrollView.showsVerticalScrollIndicator = NO;
        
    }
    
}




@end
