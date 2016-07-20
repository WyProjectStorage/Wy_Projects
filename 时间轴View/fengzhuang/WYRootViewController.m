//
//  WYRootViewController.m
//  fengzhuang
//
//  Created by 汪洋 on 15/12/14.
//  Copyright © 2015年 汪洋. All rights reserved.
//

#import "WYRootViewController.h"
#import "WYMyTableViewCell.h"
#import "UIView+WYFrame.h"
#import "WYMycollectionViewCell.h"

#import <DateTools/DateTools.h>

#define KWYTintColor [UIColor colorWithRed:0.114 green:0.757 blue:0.533 alpha:1.000]

//屏幕宽高的宏定义
#define kScreenWidth [UIScreen  mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds
#define kFitHeight(height) (height)/(667.0 - 64) * (kScreenHeight - 64)
#define kFitWidth(width) (width)/375.0 * kScreenWidth
@interface WYRootViewController ()<WYMyTableViewCellDelegate>


@end

@implementation WYRootViewController

- (instancetype)initWithLayOutStyle:(LayOutStyle)layOutStyle andSegmentStyle:(SegmentStyle)segmentStyle
{
    self = [super init];
    if (self) {
        self.segmentStyle = segmentStyle;
        self.layOutStyle = layOutStyle;
    }
    return self;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(NSMutableArray *)datasourse {
    if (!_datasourse) {
        _datasourse = [[NSMutableArray alloc] init];
    }
    return _datasourse;
}

-(NSMutableArray *)selectData {
    if (!_selectData) {
        _selectData = [NSMutableArray array];
    }
    return _selectData;
}


-(UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake(0, 0, 54, 30);
        [_editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_editBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
//        _editBtn.backgroundColor = [UIColor blackColor];
    }
    return _editBtn;
}

-(UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, 0, 54, 30);
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        //        _editBtn.backgroundColor = [UIColor blackColor];
    }
    return _cancelBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editBtn];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelBtn];
    
    
    if (self.segmentStyle == SegmentStyleDate) {
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [self addSegmentControl];
    }
    self.tableView.separatorStyle = 0;
    
//    [self reflectData];
    //    [self.tableView.tableHeaderView setHidden:YES];
}


#pragma mark  -------- ButtonActions ---------

- (void)cancelBtnClicked:(UIButton *)cancelButton {
    [self setEnableEdit:NO];
    [_selectData removeAllObjects];
    [self.editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
    [[self tableView]reloadData];
}

- (void)editBtnClicked:(UIButton *)editButton {
    if (self.enableEdit == NO) {
        self.enableEdit = YES;
        [editButton setTitle:@"删除" forState:(UIControlStateNormal)];
        
    }else{
         self.enableEdit = NO;
        [editButton setTitle:@"编辑" forState:(UIControlStateNormal)];
        [self deleteData];
       
    }
    [self.tableView reloadData];
}

//删除
-(void)deleteData{
    [self.datasourse removeObjectsInArray:self.selectData];
    [self refreshUIWithDataSourse:self.datasourse segmentIndex:self.showStyleControl.selectedSegmentIndex];
    
}

-(void)refreshUIWithDataSourse:(NSArray *)dataSourse segmentIndex:(NSInteger )index {
    self.datasourse = [NSMutableArray arrayWithArray:dataSourse];
    if (self.segmentStyle == SegmentStyleNone) {
        self.dataArray = [self getTableData:dataSourse];
    }else{
        switch (index) {
            case 0:
                //日
                _dataArray = [self getTableDataByDate:@"yyyyMMdd"];
                break;
            case 1:
                //月
                _dataArray = [self getTableDataByDate:@"yyyyMM"];
                break;
            case 2:
                //年
                _dataArray = [self getTableDataByDate:@"yyyy"];
                break;
                
            default:
                break;
        }
        [self setEnableEdit:NO];
        [_selectData removeAllObjects];
    }
    
    [[self tableView]reloadData];
}


#pragma mark ---添加年 月 日选择按钮 ---

-(void)addSegmentControl {
    self.showStyleControl = [[UISegmentedControl alloc] initWithItems:@[@"日",@"月",@"年"]];
    self.showStyleControl.frame = CGRectMake(kFitWidth(15), kFitHeight(10), kFitWidth(685/2), 30);
    self.showStyleControl.tintColor = KWYTintColor;
    self.showStyleControl.selectedSegmentIndex = 0;
    [self.showStyleControl addTarget:self action:@selector(ChangeShowStyle:) forControlEvents:(UIControlEventValueChanged)];
    [self.tableView.tableHeaderView addSubview:self.showStyleControl];
}

//segmentControl 点击变化事件
- (void)ChangeShowStyle:(UISegmentedControl *)segmentControl {
    
    [self refreshUIWithDataSourse:self.datasourse segmentIndex:segmentControl.selectedSegmentIndex];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----- Table view data source ----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *LayoutString;
    if (self.layOutStyle == LayOutWithOne) {
        LayoutString = @"one";
    }else{
        LayoutString = @"three";
    }
    static NSString *reuseIdetify = @"WYMycell";
    WYMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (cell == nil) {
        cell = [[WYMyTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdetify LayoutStyle:LayoutString];
    }
    cell.editEnable = self.enableEdit;//同步可编辑状态
    cell.cellDelegate = self;
    cell.selectedBtn = self.selectData;
    cell.cellSection = indexPath.row;
    cell.lineView.frame = CGRectMake(cell.lineView.left, cell.lineView.top, cell.lineView.width, [self getCellHeightAtIndexPath:indexPath] - cell.lineView.top - 2);
    
    cell.collectArray = self.dataArray[indexPath.row];
    WYDataModel *model = cell.collectArray.firstObject;
    CGFloat cheight ;
    
    if (self.layOutStyle == LayOutWithOne) {
        cheight = cell.collectArray.count * (kFitWidth(85) + 5);
    }else {
        if (cell.collectArray.count % 3 == 0) {
            cheight = cell.collectArray.count / 3 * (kFitWidth(85) + 5);
        }else {
            cheight = (cell.collectArray.count / 3 + 1) * (kFitWidth(85) + 5);
        }
    }
    CGRect frame = cell.WYMycollectionView.frame;
    frame.size.height = cheight;
    cell.WYMycollectionView.frame = frame;
    cell.selectionStyle = 0;
    [cell.WYMycollectionView reloadData];
    if (self.segmentStyle == SegmentStyleDate) {
    cell.smallLabel.text = [self getDateTextWithDate:model.insertTime];
    }else{
     cell.smallLabel.text = [model.insertTime formattedDateWithFormat:@"yyyy年MM月"];
    }
    return cell;
}

#pragma mark ------ WYMyTableViewCellDelegate ------

- (void)didSelectedObject:(WYDataModel *)object AtIndexPath:(NSIndexPath *)indexPath WithSelectArray:(NSMutableArray *)array {
    NSLog(@"%@",indexPath);
    if (self.enableEdit) {
        if ([self.selectData containsObject:object]) {
            [self.selectData removeObject:object];
        }else{
            [self.selectData addObject:object];
        }
        
        [self.tableView reloadData];
    }else{
//        if (self.rootViewdelegate && [self respondsToSelector:[]) {
//            
//        }
    }
    
}


-(void) didSelectedObject:(WYDataModel *)object AtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSString *)getDateTextWithDate:(NSDate *)date{
    NSString *dateStr;
    if (self.showStyleControl.selectedSegmentIndex == 0) {
       dateStr = [NSString stringWithFormat:@"%@\n%@%@",[date formattedDateWithFormat:@"dd日"],[date formattedDateWithFormat:@"MM月"],[date formattedDateWithFormat:@"yyyy年"]];
    }
    if (self.showStyleControl.selectedSegmentIndex == 1) {
       dateStr = [NSString stringWithFormat:@"%@\n%@",[date formattedDateWithFormat:@"MM月"],[date formattedDateWithFormat:@"yyyy年"]];
    }
    if (self.showStyleControl.selectedSegmentIndex == 2) {
       dateStr = [date formattedDateWithFormat:@"yyyy年"];
    }
    return dateStr;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getCellHeightAtIndexPath:indexPath];
}


-(CGFloat)getCellHeightAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cheight ;
    if (self.layOutStyle == LayOutWithOne) {
        cheight = ([self.dataArray[indexPath.row] count]) * (kFitWidth(85) + 5);
    }else {
        if ([self.dataArray[indexPath.row] count] % 3 == 0) {
            cheight = [self.dataArray[indexPath.row] count] / 3 * (kFitWidth(85)  + 5);
        }else {
            cheight = ([self.dataArray[indexPath.row] count] / 3 + 1) * (kFitWidth(85)  + 5);
        }
    }
    return cheight + 15;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

//根据天获取
- (NSMutableArray *)getTableDataByDate:(NSString*) dateformate{
    NSMutableDictionary *dir =[[NSMutableDictionary alloc]init];
    for (WYDataModel *model in _datasourse) {
        NSString *key = [model.insertTime formattedDateWithFormat:dateformate];
        
        if(dir[key]){
            [dir[key] addObject:model];
        }else{
            dir[key] = [[NSMutableArray alloc]init];
            [dir[key] addObject:model];
        }
    }
    //key排序
    NSArray *keyarray = [dir allKeys];
    keyarray = [keyarray sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        
        return [[NSDate dateWithString:obj2 formatString:dateformate] compare:[NSDate dateWithString:obj1 formatString:dateformate]];
    }];
    NSMutableArray *temparray = [[NSMutableArray alloc]init];
    
    for (NSString *key in keyarray) {
        
        [temparray addObject:dir[key]];
    }
    
    return temparray;
    
}




//根据时间获取
- (NSMutableArray *)getTableData:(NSArray *)array{
    
    NSMutableDictionary *dir =[[NSMutableDictionary alloc]init];
    
    for (WYDataModel *model in array) {
        NSString *key                                  = [model.insertTime formattedDateWithFormat:@"yyyyMMdd hh"];
        
        if(dir[key]){
            [dir[key] addObject:model];
        }else{
            dir[key]                                       = [[NSMutableArray alloc]init];
            [dir[key] addObject:model];
        }
    }
    
    //key排序
    NSArray *keyarray                              = [dir allKeys];
    keyarray                                       = [keyarray sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        return [[NSDate dateWithString:obj2 formatString:@"yyyyMMdd hh"] compare:[NSDate dateWithString:obj1 formatString:@"yyyyMMdd hh"]];
    }];
    NSMutableArray *temparray                      = [[NSMutableArray alloc]init];
    for (NSString *key in keyarray) {
        [temparray addObject:dir[key]];
    }
    
    return temparray;
}


@end
