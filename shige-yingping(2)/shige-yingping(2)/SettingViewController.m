//
//  SettingViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *moshiLabel;
@property (weak, nonatomic) IBOutlet UILabel *zitiLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customUI];
}

//手势事件
- (void)TapGestureClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customUI{
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectButton.frame = CGRectMake(kScreenSize.width-50, 64, 40, 40);
    [self.selectButton addTarget:self action:@selector(moshiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectButton];
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"button_select"] forState:UIControlStateNormal];
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateSelected];
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if (them ==nil) {
        self.selectButton.selected = NO;
        them = @"0";
    }else{
        self.selectButton.selected = [them boolValue];
    }    
    [self setThemColor:them];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moshiBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSString stringWithFormat:@"%d",sender.selected]forKey:kThemeName];
    [defaults synchronize];
    
    NSString * them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    [self setThemColor:them];
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:nil];
}

- (void)setThemColor:(NSString *)them{
    //NSLog(@"them :%@",them);
    if (![them boolValue]) {//白天
        self.view.backgroundColor = kWhiteColor;
        self.moshiLabel.textColor = kBlackColor;
        self.zitiLabel.textColor = kBlackColor;
        self.titleLabel.textColor = kBlackColor;
    }else{//夜间模式
        self.view.backgroundColor = kBackeColor;
        self.moshiLabel.textColor = kWhiteColor;
        self.zitiLabel.textColor = kWhiteColor;
        self.titleLabel.textColor = kWhiteColor;
    }

}
@end
