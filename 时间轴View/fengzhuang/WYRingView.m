//
//  WYRingView.m
//  SmartDemo
//
//  Created by 汪洋 on 15/11/17.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "WYRingView.h"

@implementation WYRingView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height / 2;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 4;
        self.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    return self;
}
@end
