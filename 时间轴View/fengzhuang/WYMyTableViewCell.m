//
//  WYMyTableViewCell.m
//  fengzhuang
//
//  Created by 汪洋 on 15/12/14.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "WYMyTableViewCell.h"
#import "UIView+WYFrame.h"
#import "WYMycollectionViewCell.h"
#import "WYDataModel.h"
#import <DateTools.h>

#define KWYTintColor [UIColor colorWithRed:0.114 green:0.757 blue:0.533 alpha:1.000]
//屏幕宽高的宏定义
#define kScreenWidth [UIScreen  mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds
#define kFitHeight(height) (height)/(667.0 - 64) * (kScreenHeight - 64)
#define kFitWidth(width) (width)/375.0 * kScreenWidth
@implementation WYMyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier LayoutStyle:(NSString *)LayoutStyle
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.WYRingView = [[WYRingView alloc] initWithFrame:CGRectMake(kScreenWidth / 5 - 15, 0, 15, 15)];
        self.WYRingView.layer.borderColor = [[UIColor colorWithRed:167%256/255.0 green:167 % 256/255.0 blue:167%256/255.0 alpha:1] CGColor];
        [self.contentView addSubview:self.WYRingView];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(self.WYRingView.left + 7.5 - 2, self.WYRingView.bottom + 2, 4, self.frame.size.height - 15 - 2 - 2)];
        self.lineView .layer.masksToBounds = YES;
        self.lineView .layer.cornerRadius = 2;
        self.lineView .backgroundColor = KWYTintColor;
        [self.contentView addSubview:self.lineView];
        
        self.bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15/2 - 2, kScreenWidth / 5 - 10, 15)];
        self.bigLabel.textAlignment = NSTextAlignmentCenter;
        //        self.bigLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.bigLabel];
        
        self.smallLabel = [[FitTopLabel alloc] initWithFrame:CGRectMake(0, self.bigLabel.bottom, kFitWidth(60), kFitWidth(60))];
        self.smallLabel.textAlignment = NSTextAlignmentCenter;
        self.smallLabel.numberOfLines = 0;
        self.smallLabel.text = @"2015年08月";
        self.smallLabel.textAlignment = NSTextAlignmentCenter;
        self.smallLabel.verticalAlignment = VerticalAlignmentTop;
        self.smallLabel.font = [UIFont systemFontOfSize:kFitHeight(13)];
//        self.smallLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.smallLabel];
        self.layOutStyle = LayoutStyle;
        [self addCollection];
        [self.WYMycollectionView registerClass:[WYMycollectionViewCell class] forCellWithReuseIdentifier:@"WYMycollectCell"];
 
    }
    return self;
}

-(UICollectionView *)WYMycollectionView {
    if (!_WYMycollectionView) {
         UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        if ([self.layOutStyle isEqualToString:@"one"]) {
            
            layout.minimumLineSpacing = 5;
            layout.sectionInset = UIEdgeInsetsMake(0, kFitWidth(15), 0, kFitWidth(100));
            layout.minimumInteritemSpacing = 5;
            layout.itemSize = CGSizeMake(kFitWidth(100), kFitWidth(85));
            
        }else{
            layout.minimumLineSpacing = 5;
            layout.sectionInset = UIEdgeInsetsMake(0, kFitWidth(5), 0, kFitWidth(15));
            layout.minimumInteritemSpacing = 5;
            layout.itemSize = CGSizeMake(kFitWidth(85), kFitWidth(85));
        }
        
        self.WYMycollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.WYRingView.right + 5, self.WYRingView.top + self.WYRingView.height / 2,kScreenWidth - self.WYRingView.right - 10,0)collectionViewLayout:layout];
        [self.contentView addSubview:self.WYMycollectionView];

    }
    return _WYMycollectionView;
}

-(NSMutableArray *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [NSMutableArray array];
    }
    return _selectedBtn;
}

-(void)addCollection {
    self.cellHeight = self.WYMycollectionView.height + self.WYRingView.height / 2 + 5;
    self.WYMycollectionView.delegate = self;
    self.WYMycollectionView.dataSource = self;
    self.WYMycollectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark --- 集合视图代理方法 -----
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.collectArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WYDataModel *model = self.collectArray[indexPath.row];
    WYMycollectionViewCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WYMycollectCell" forIndexPath:indexPath];
        if (self.editEnable) {
            listCell.selectButton.hidden = NO;
            if ([self.selectedBtn containsObject:model]) {
                listCell.selectButton.image = [UIImage imageNamed:@"复选框-选中-拷贝-7"];
            }else{
                listCell.selectButton.image = [UIImage imageNamed:@"复选框-未选-拷贝-12"];
            }
        }else{
            listCell.selectButton.hidden = YES;
            listCell.selectButton.image = [UIImage imageNamed:@"复选框-未选-拷贝-12"];
        }
    
//    listCell.picture.image = [self getImage:model.filePath];
    listCell.timeLabel.text = [model.insertTime formattedDateWithFormat:@"hh:mm"];
    return listCell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
//    WYDataModel *model = self.collectArray[indexPath.row];
//    if ([self.selectedBtn containsObject:model]) {
//        [self.selectedBtn removeObject:model];
//    }else{
//        [self.selectedBtn addObject:model];
//    }
    [self.cellDelegate didSelectedObject:[self.collectArray objectAtIndex:indexPath.row] AtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:self.cellSection] WithSelectArray:self.selectedBtn];
}


-(NSArray *)collectArray {
    if (!_collectArray) {
        _collectArray = [[NSArray alloc] init];
    }
    return _collectArray;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
