//
//  CriticCell.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CriticCell.h"

@interface CriticCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintHeight;
@end

@implementation CriticCell

- (void)awakeFromNib {
    [self setThemBackColor];
    kPrint;
}
- (void)setThemBackColor{
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    NSLog(@"%@,setThemBackColor - CriticCell",them);
    if (![them boolValue]||them==nil) {
        self.titleLabel.textColor = kBlackColor;
        self.contentView.backgroundColor = kWhiteColor;
    }else{
        self.titleLabel.textColor = kWhiteColor;
        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
}

- (void)showDataWithModel:(NSDictionary *)model{

    self.titleLabel.text = model[@"text"];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    if (![model[@"image"]isEqualToString:@""]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:[NSString stringWithFormat:ImageURL,model[@"image"]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSData *data = (NSData *)responseObject;
             UIImage *image = [UIImage imageWithData:data];
            self.headImageView.image = image;
            self.ConstraintHeight.constant = 150;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"图片下载失败");
        }];
        
       
    }else{
        self.ConstraintHeight.constant = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
