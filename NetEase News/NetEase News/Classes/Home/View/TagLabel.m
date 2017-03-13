//
//  TagLabel.m
//  NetEase News
//
//  Created by 许世强 on 2017/3/10.
//  Copyright © 2017年 许世强. All rights reserved.
//

#import "TagLabel.h"

@implementation TagLabel

- (void)setScalePercent:(CGFloat)scalePercent{

    _scalePercent = scalePercent;
    
    //根据百分比,颜色渐变
    self.textColor = [UIColor colorWithRed:scalePercent green:0 blue:0 alpha:1];
    
    //缩放  最小倍数应该设置为1开始
    CGFloat currentScalePrecent = 1 + scalePercent * 0.3;
    self.transform = CGAffineTransformMakeScale(currentScalePrecent, currentScalePrecent);
}

@end
