//
//  headView.h
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadViewDelegate <NSObject>
- (void)sendEvetent:(UIButton *)btn;
@end
@interface headView : UIView

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign,nonatomic)id<HeadViewDelegate>delegate;
- (IBAction)btnClick:(UIButton *)sender;

- (void)showViewWithModel:(NSDictionary *)model;

@end
