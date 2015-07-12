//
//  NovelCell.h
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
@interface NovelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)showDataWithModel:(NSDictionary *)model withKey:(NSString *)key;
@end
