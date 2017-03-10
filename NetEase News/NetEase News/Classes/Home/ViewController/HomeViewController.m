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

@interface HomeViewController ()

@property(nonatomic, strong)NSArray<TagModel *> *tagModelArray;

//频道标签视图
@property (weak, nonatomic) IBOutlet UIScrollView *tagScrollView;

//新闻视图
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tagModelArray = [NSArray array];
    
    //iOS 7 ,滚动视图向下默认偏移74
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadTagData];
}


- (void)loadTagData{
    
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
