//
//  WYDataModel.h
//  fengzhuang
//
//  Created by 汪洋 on 16/4/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,MediaType){
    MediaTypeImage = 1,
    MediaTypeVideo
};

@interface WYDataModel : NSObject
/**
 *  预览图片
 */
@property(nonatomic,copy) UIImage *preimgae;
/**
 *  记录编号
 */
@property (nonatomic, assign) NSInteger recordid;
/**
 *  文件名称
 */
@property (nonatomic,copy) NSString *filename;
/**
 *  插入时间
 */
@property (nonatomic,copy) NSDate *insertTime;

//1--截屏  2--录制
@property (nonatomic,copy) NSString *type;

/**
 *  文件路径(地址)
 */
@property (nonatomic, copy) NSString *fileURl;

/**
 *  文件类型
 */
@property (nonatomic, assign) MediaType mediatype;


@end
