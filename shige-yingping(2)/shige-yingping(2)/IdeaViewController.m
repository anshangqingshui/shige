//
//  IdeaViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "IdeaViewController.h"

@interface IdeaViewController ()

@end

@implementation IdeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customUI];
}
- (void)customUI{
    UIImageView *background =[[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"conus" ofType:@"png"]]];
    background.frame = CGRectMake(0, 0, 360, 265);
    background.center = self.view.center;
    background.backgroundColor = [UIColor clearColor];
    [self.view addSubview:background];
    [self setThemColor];
}

- (void)setThemColor{
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if (![them boolValue]||them==nil) {
        self.view.backgroundColor = kWhiteColor;
    }else{
        self.view.backgroundColor = kBackeColor;
        UIView *shadowView = [[UIView alloc]initWithFrame:self.view.frame];
        [self.view.subviews[0] addSubview:shadowView];
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
