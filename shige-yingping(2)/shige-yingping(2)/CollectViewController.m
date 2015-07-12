//
//  CollectViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CollectViewController.h"

@interface CollectViewController ()

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customUI];
}
- (void)customUI{
    UIImageView *background =[[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favnull" ofType:@"png"]]];
    background.backgroundColor = [UIColor clearColor];
    background.frame = CGRectMake(0, 0, 449, 389);
    background.center = self.view.center;
    [self.view addSubview:background];
   
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
