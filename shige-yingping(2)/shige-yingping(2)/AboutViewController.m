//
//  AboutViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customUI];
}

- (void)customUI{
    UIImageView *backimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64)];
    backimageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"about_us_bg" ofType:@"png"]];
    [self.view addSubview:backimageView];
    [self setThemColor];
}

- (void)setThemColor{
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if (![them boolValue]||them==nil) {
        self.view.backgroundColor = kWhiteColor;
    }else{
        self.view.backgroundColor = kBlackColor;
    }
}

//手势事件
- (void)TapGestureClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
