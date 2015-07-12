//
//  FootView.h
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
@interface FootView : UIView

@property (nonatomic,strong)UILabel *autherLable;
@property (nonatomic,strong)UILabel *nameLable;

- (void)showDataWithModel:(NSDictionary *)model;

@end
