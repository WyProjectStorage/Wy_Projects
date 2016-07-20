//
//  WYDataModel.m
//  fengzhuang
//
//  Created by 汪洋 on 16/4/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "WYDataModel.h"

@implementation WYDataModel

+ (WYDataModel *)setModelValueWithDic:(NSDictionary *)dic {
    
    WYDataModel *model = [[WYDataModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@",key);
}


@end
