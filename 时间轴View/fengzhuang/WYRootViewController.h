//
//  WYRootViewController.h
//  fengzhuang
//
//  Created by 汪洋 on 15/12/14.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYDataModel.h"
typedef NS_ENUM(NSInteger,LayOutStyle)
{
    LayOutWithOne = 1,
    LayOutWithThree
    
};

typedef NS_ENUM(NSInteger,SegmentStyle)
{
    SegmentStyleNone = 1,
    SegmentStyleDate
};
@protocol WyRootViewDelegate <NSObject>

- (void)didselectedObject:(WYDataModel *)object;

@end

@interface WYRootViewController : UITableViewController 
@property (nonatomic, strong) NSMutableArray *datasourse;
@property (nonatomic, strong) __block NSMutableArray *dataArray;

@property (nonatomic, strong) UISegmentedControl *showStyleControl;

@property (nonatomic, assign) LayOutStyle layOutStyle;

@property (nonatomic, assign) SegmentStyle segmentStyle;

@property(nonatomic,assign)BOOL enableEdit;

@property(nonatomic,copy)UIButton *titleBtn;

@property(nonatomic,copy)NSMutableArray *selectData;

@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic,strong)UIButton *editBtn;

@property (nonatomic, assign)id<WyRootViewDelegate>rootViewdelegate;

/**
 *  初始化方法
 *
 *  @param layOutStyle  布局种类(单行排列/一行三个)
 *  @param segmentStyle 是否显示日月年分类
 *
 *  @return
 */
- (instancetype)initWithLayOutStyle:(LayOutStyle)layOutStyle andSegmentStyle:(SegmentStyle)segmentStyle;

/**
 *  根据dataSource刷新界面
 *
 *  @param dataSourse 数据源(单层数组)
 *  @param index      日月年分类
 */
-(void)refreshUIWithDataSourse:(NSArray *)dataSourse segmentIndex:(NSInteger )index;

/**
 *  删除方法
 *
 *  @param dataSoruse 删除后的数据源
 */
-(void)deleteData;

/**
 *  非编辑状态下的点击事件
 *
 *  @param object
 *  @param indexPath 
 */
-(void) didSelectedObject:(WYDataModel *)object AtIndexPath:(NSIndexPath *)indexPath;


@end
