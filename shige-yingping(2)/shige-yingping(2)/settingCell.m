//
//  settingCell.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "settingCell.h"
@interface settingCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titieLabel;

@end
@implementation settingCell

- (void)awakeFromNib {
    // Initialization code
   self.iconImageView.layer.masksToBounds = YES;
   self.iconImageView.layer.cornerRadius = 22;
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setThemBackColor) name:kThemeDidChangeNotification object:nil];
    [self setThemBackColor];
}

- (void)setThemBackColor{
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if (![them boolValue]||them==nil) {
        self.titieLabel.textColor = kBlackColor;
        self.contentView.backgroundColor = kWhiteColor;
    }else{
        self.titieLabel.textColor = kWhiteColor;
        self.contentView.backgroundColor = kCellBlackColor;
    }
}


- (void)showDataWithModel:(NSDictionary *)model{
    self.titieLabel.text = model[@"text"];
    self.iconImageView.image = [UIImage imageNamed:model[@"image"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
