//
//  TestViewController.m
//  fengzhuang
//
//  Created by 汪洋 on 16/4/8.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "TestViewController.h"
#import "WYDataModel.h"
#import <DateTools.h>
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshUIWithDataSourse:[self reflectData] segmentIndex:0];
}

-(NSArray *) reflectData {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        WYDataModel *model = [[WYDataModel alloc] init];
        model.filename = @"lalal";
        model.insertTime = [NSDate dateWithYear:1992 month:12 day:11 hour:6 minute:13 second:24];
        [array addObject:model];
    }
    
    for (int i = 0; i < 5; i++) {
        WYDataModel *model = [[WYDataModel alloc] init];
        model.filename = @"lalal";
        model.insertTime = [NSDate dateWithYear:1992 month:5 day:13 hour:7 minute:45 second:24];
        [array addObject:model];
    }
    for (int i = 0; i < 5; i++) {
        WYDataModel *model = [[WYDataModel alloc] init];
        model.filename = @"gjdjsh";
        model.insertTime = [NSDate dateWithYear:2010 month:3 day:23 hour:23 minute:13 second:24];
        [array addObject:model];
    }
    
    return array;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
