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

//创建数组记录频道标签
@property(nonatomic,strong) NSMutableArray *tagLabelArray;

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

#pragma mark -- 05 频道标签的缩放, 颜色变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //计算小数索引
    CGFloat floatIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //计算整数索引
    int intIndex =scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //获取小数点位
    CGFloat precent = floatIndex - intIndex;
    
    //获取当前标签的百分比
    CGFloat nowPrecent = 1 - precent;
    
    //获取下一个标签的百分比
    CGFloat nextPrecent = precent;
    
    //当前的索引为
    int nowIndex = intIndex;
    
    //下一个索引为
    int nextIndex = intIndex + 1;
    
    //从数组中根据索引获取label
    TagLabel *nowLabel = self.tagLabelArray[nowIndex];
    
    //给label的百分比属性传值,设置当前标签的百分比
    nowLabel.scalePercent = nowPrecent;
    
    //  判断右边的频道的标签是否超出可用的取值访问 , [0-46]
    if (nextIndex < self.tagLabelArray.count) {
        TagLabel *nextLabel = self.tagLabelArray[nextIndex];
       nextLabel.scalePercent = nextPrecent;
    }
    
}


#pragma mark -- 04 滚动collectionView,联动标签
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //滚动的大小除以屏幕的宽度,计算index
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    TagLabel *tagLabel = self.tagLabelArray[index];
    
    [self scrollTageLabel:tagLabel];
    
}

//滚动到指定的标签频道在屏幕中心x显示
- (void)scrollTageLabel:(TagLabel *)tagLabel{
    
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

#pragma mark -- 03 点击频道标签,要显示在居中位置
//点击频道标签的手势处理
- (void)tapChannelLabelAction:(UITapGestureRecognizer *)gesture{

    TagLabel *tagLabel = (TagLabel *)gesture.view;
    
    [self scrollTageLabel:tagLabel];
    
    //MARK: 联动下方的collectionView滚动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:tagLabel.tag inSection:0];
    
    //设置滚动
    [self.newsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    //  遍历频道数组,判断点击的频道和数组里面的频道进行查找,如果找到了,那么放大,否则显示默认状态
    for (TagLabel *channelabel in self.tagLabelArray) {
        if (tagLabel == channelabel) {
            //  设置变大变红
            channelabel.scalePercent = 1;
        } else {
            //  其它频道标签设置成默认状态就可以了
            channelabel.scalePercent = 0;
        }
    }
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
    
    self.tagLabelArray = [NSMutableArray array];
    
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
        
        //设置tag  用于点击标签联动下方的collec滚动
        label.tag = i;
        
        //将label添加到数组中
        [self.tagLabelArray addObject:label];
        
        //  表示头条新闻
        if (i == 0) {
            label.scalePercent = 1;
        }
    }
    
    //MARK:设置contentSize
    self.tagScrollView.contentSize = CGSizeMake(tagLabelWidth * self.tagModelArray.count, 0);
    
    self.tagScrollView.showsHorizontalScrollIndicator = NO;
    self.tagScrollView.showsVerticalScrollIndicator = NO;
    
    
}




@end
