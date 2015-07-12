//
//  CriticCell.h
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Helper.h"


@interface CriticCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)showDataWithModel:(NSDictionary *)model;

@end
