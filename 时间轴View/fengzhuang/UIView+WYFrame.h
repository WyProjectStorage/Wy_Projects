//
//  UIView+WYFrame.h
//  Fuxi
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 Baked. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WYFrame)

//  高度
@property (nonatomic,assign) CGFloat height;
//  宽度
@property (nonatomic,assign) CGFloat width;

//  Y
@property (nonatomic,assign) CGFloat top;
//  X
@property (nonatomic,assign) CGFloat left;

//  Y + Height
@property (nonatomic,assign) CGFloat bottom;
//  X + width
@property (nonatomic,assign) CGFloat right;

@end
