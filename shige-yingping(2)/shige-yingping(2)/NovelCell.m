//
//  NovelCell.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NovelCell.h"
#import "NovelViewController.h"
#import "AFNetworking.h"
@interface NovelCell()<NovelDelegate>
@property (nonatomic,strong)UIImage *image;
@end

@implementation NovelCell

- (void)awakeFromNib {
    // Initialization code
    [self setThemBackColor];
    kPrint;
}

- (void)setThemBackColor{
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if (![them boolValue]||them==nil) {
        self.nameLabel.textColor = kBlackColor;
        self.contentView.backgroundColor = kWhiteColor;
    }else{
        self.nameLabel.textColor = kWhiteColor;
        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
}


- (void)showDataWithModel:(NSDictionary *)model withKey:(NSString *)key{
    self.iconView.image =self.image;
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.image = nil;
    [manger GET:[NSString stringWithFormat:ImageURL,[model valueForKey:key]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = (NSData *)responseObject;
        self.image = [UIImage imageWithData:data];
        self.iconView.image = self.image;
        [self picturAndText:self.image withModel:model];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"问章图片下载失败");
    }];

    
    if (model[@"summary"]) {
        self.summaryLabel.text = model[@"summary"];
    }
    if (model[@"text"]) {
        self.nameLabel.text = model[@"text"];
    }else{
        self.nameLabel.text = model[@"text2"];
    }
}
- (UIImage *)sendImageData:(NSDictionary *)model{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (!self.image) {
        [manger GET:[NSString stringWithFormat:ImageURL,model[@"image"]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = (NSData *)responseObject;
            self.image = [UIImage imageWithData:data];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"问章图片下载失败");
        }];
    }
    return self.image;
}

//图文混排
- (void)picturAndText:(UIImage *)image withModel:(NSDictionary *)model{
    CGFloat Height = 10;
    CGFloat h = 0;
    CGRect iconViewFrame = self.iconView.frame;
    CGRect summaryFrame = self.summaryLabel.frame;
    CGRect backFram = self.backView.frame;
    CGRect nameFram = self.nameLabel.frame;
    h = (image.size.height/image.size.width)*iconViewFrame.size.width;
    Height += (h+10);
    iconViewFrame.size.height = h;
    if(model[@"summary"]){
        h = [Helper textHeightFromTextString:model[@"summary"] width:(kScreenSize.width-30) fontSize:14];
        summaryFrame.size.height = h;
        backFram.origin.y = Height;
        backFram.size.height = h+40;
        Height += (h+50);
        self.summaryLabel.frame = summaryFrame;
    }else{
        for (UIView *view in self.backView.subviews) {
           // [view removeFromSuperview];
            view.frame =CGRectZero;
        }
        self.backView.frame =CGRectZero;
        backFram.size.height = 0;
    }
    nameFram.origin.y = Height;
    NSString *text = nil;
    if ([model[@"text"]isKindOfClass:[NSString class]]) {
        text = model[@"text"];
    }else{
        text = model[@"text2"];
    }
    h = [Helper textHeightFromTextString:text width:(kScreenSize.width-20) fontSize:14];
    nameFram.size.height = h;
    self.iconView.frame = iconViewFrame;
    self.backView.frame = backFram;
    self.nameLabel.frame = nameFram;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
