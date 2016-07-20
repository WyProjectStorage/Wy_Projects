//
//  WYMyTableViewCell.h
//  fengzhuang
//
//  Created by 汪洋 on 15/12/14.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYRingView.h"
#import "FitTopLabel.h"
#import "WYDataModel.h"

@protocol WYMyTableViewCellDelegate <NSObject>

- (void)didSelectedObject:(WYDataModel *)object AtIndexPath:(NSIndexPath *)indexPath WithSelectArray:(NSMutableArray *)array;

@end


@interface WYMyTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *WYMycollectionView;
@property (nonatomic, strong) WYRingView *WYRingView;
@property (nonatomic, strong) UILabel *bigLabel;
@property (nonatomic, strong) FitTopLabel *smallLabel;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic, assign) NSInteger cellSection;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSArray *collectArray;
@property (nonatomic, copy) NSString  *layOutStyle;
@property (nonatomic) BOOL editEnable;
@property (nonatomic, strong) NSMutableArray *selectedBtn;
@property (nonatomic, assign)id <WYMyTableViewCellDelegate>cellDelegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier LayoutStyle:(NSString *)LayoutStyle;

@end
