//
//  NewsTableViewCell.m
//  NetEase News
//
//  Created by 许世强 on 2017/3/11.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface NewsTableViewCell ()

//图片
@property (weak, nonatomic) IBOutlet UIImageView *imageSrc;

//标题
@property (weak, nonatomic) IBOutlet UILabel *labelTittle;

//来源
@property (weak, nonatomic) IBOutlet UILabel *labelSource;

//回复
@property (weak, nonatomic) IBOutlet UILabel *labelReply;

@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.imageSrc.contentMode = UIViewContentModeScaleAspectFill;
    self.imageSrc.clipsToBounds = YES;
}

- (void)setNewsModel:(NewsModel *)newsModel{

    _newsModel = newsModel;
    
    //控件加载网络图片
    [self.imageSrc sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
    self.labelTittle.text = newsModel.title;
    
    self.labelSource.text = newsModel.source;
    
    self.labelReply.text = [NSString stringWithFormat:@"%zd", newsModel.replyCount];
}

@end
