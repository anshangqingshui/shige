//
//  FootView.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FootView.h"


@implementation FootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatView];
    }
    return self;
}

- (void)creatView{
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenSize.width-20, 21)];
    self.nameLable.textAlignment = NSTextAlignmentLeft;
    self.nameLable.font =[UIFont systemFontOfSize:12];
    self.nameLable.numberOfLines = 0;
    self.autherLable =[[UILabel alloc]initWithFrame:CGRectMake(10, 31, kScreenSize.width-20, 21)];
    [self addSubview:self.nameLable];
    self.autherLable.textAlignment = NSTextAlignmentLeft;
    self.autherLable.font =[UIFont systemFontOfSize:12];
    self.autherLable.numberOfLines = 0;
    [self addSubview:self.autherLable];

}
- (void)setThemBackColor{
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if (![them boolValue]||them==nil) {
        self.autherLable.textColor = kBackeColor;
        self.nameLable.textColor = kBackeColor;
        self.backgroundColor = kWhiteColor;
    }else{
        self.autherLable.textColor = kWhiteColor;
        self.nameLable.textColor = kWhiteColor;
        self.backgroundColor = kBackeColor;
    }
}


- (void)showDataWithModel:(NSDictionary *)model{
    CGRect frame = self.autherLable.frame;
    self.autherLable.text = model[@"authorbrief"];
    self.nameLable.text = model[@"author"];
    frame.size.height = [Helper textHeightFromTextString:model[@"authorbrief"] width:(kScreenSize.width-20) fontSize:12];
    self.autherLable.frame =frame;

}

@end
