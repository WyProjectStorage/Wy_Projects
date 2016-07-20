//
//  WYMycollectionViewCell.m
//  fengzhuang
//
//  Created by 汪洋 on 15/12/14.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "WYMycollectionViewCell.h"
#import "UIView+WYFrame.h"
//屏幕宽高的宏定义
#define kScreenWidth [UIScreen  mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds
#define kFitHeight(height) (height)/(667.0 - 64) * (kScreenHeight - 64)
#define kFitWidth(width) (width)/375.0 * kScreenWidth
@implementation WYMycollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.picture = [[UIImageView alloc] initWithFrame:self.bounds];
        self.picture.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.picture];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.picture.right - 35, self.picture.bottom - 15, 35, 15)];
        self.timeLabel.backgroundColor = [UIColor blackColor];
        self.timeLabel.text = @"13:48";
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.picture addSubview:self.timeLabel];
        
        self.selectButton = [[UIImageView alloc] initWithFrame:CGRectMake(self.picture.right - 22, 2, 20, 20)];
        self.selectButton.image = [UIImage imageNamed:@"复选框-未选-拷贝-12"];
        [self.picture addSubview:self.selectButton];
        self.selectButton.hidden = YES;
    }
    return self;
}

@end
