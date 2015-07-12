//
//  CriticModel.h
//  shige-yinping
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 牛鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CriticModel : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *author;
@property (nonatomic,copy)NSString *authorbrief;
@property (nonatomic,strong)NSNumber *times;
@property (nonatomic,copy)NSString *text1;
@property (nonatomic,copy)NSString *text2;
@property (nonatomic,copy)NSString *text3;
@property (nonatomic,copy)NSString *text4;
@property (nonatomic,copy)NSString *text5;
@property (nonatomic,copy)NSString *image1;
@property (nonatomic,copy)NSString *image2;
@property (nonatomic,copy)NSString *image3;
@property (nonatomic,copy)NSString *image4;
@property (nonatomic,copy)NSString *imageforplay;
@property (nonatomic,copy)NSString *urlforplay;
@property (nonatomic,strong)NSNumber *publishtime;
@property (nonatomic,strong)NSNumber *status;


@end
