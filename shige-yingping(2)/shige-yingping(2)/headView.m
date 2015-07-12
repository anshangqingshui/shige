//
//  headView.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "headView.h"
#import "Helper.h"
#import "UIImageView+AFNetworking.h"
@implementation headView

- (void)awakeFromNib{
    [self setThemBackColor];
}


- (void)setThemBackColor{
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if (![them boolValue]||them==nil) {
        self.nameLabel.textColor = kBlackColor;
        self.backgroundColor = kWhiteColor;
        self.titleLabel.textColor = kBackeColor;
        self.timeLabel.textColor = kBackeColor;
    }else{
        self.nameLabel.textColor = kWhiteColor;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.001];
        self.titleLabel.textColor = kWhiteColor;
        self.timeLabel.textColor = kWhiteColor;
    }
    self.shareButton.selected = NO;
}

- (IBAction)btnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sendEvetent:)]) {
        [self.delegate performSelector:@selector(sendEvetent:) withObject:self.shareButton];
        sender.selected = !sender.selected;
    }
}

- (void)showViewWithModel:(NSDictionary *)model{
    CGRect nameFrame = self.nameLabel.frame;
    CGRect titleFrame = self.titleLabel.frame;
    CGRect imageFrame =self.iconImageView.frame;
     self.timeLabel.text = [Helper dateStringFromNumberTimer:model[@"publishtime"]];
    self.nameLabel.numberOfLines = 0;
    if([model[@"imageforplay"] length]){
        [self.iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ImageURL,model[@"imageforplay"]]]placeholderImage:[UIImage imageNamed:@"icon_favorite_tip"]];
    }else{
       // nameFrame.origin.y -= imageFrame.size.height;
       // titleFrame.origin.y -= imageFrame.size.height;
        imageFrame = CGRectZero;
    }
    nameFrame.size.height = [Helper textHeightFromTextString:model[@"title"] width:(kScreenSize.width-25) fontSize:17]+10;
   
    self.iconImageView.frame = imageFrame;
    self.nameLabel.frame = nameFrame;
    self.titleLabel.frame = titleFrame;
    self.nameLabel.text = model[@"title"];
    self.titleLabel.text = [NSString stringWithFormat:@"作者%@ | 阅读量%@",model[@"author"],model[@"times"]];
   }

@end
