//
//  rootViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "rootViewController.h"
#import "baseViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatMyTabBar];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification) name:kThemeDidChangeNotification object:nil];
    kPrint;
}

- (void)creatCotrollers{
    NSMutableArray *controlls = [[NSMutableArray alloc]init];
    NSArray *classNames = @[@"CriticViewController",@"NovelViewController",@"DiagramViewController",@"OwnViewController"];
    NSArray *arr = @[CriticHomeURL,NovelHomeURL,DiagramHomeURL];
    for (NSInteger i = 0; i<classNames.count; i++) {
        Class myClass = NSClassFromString(classNames[i]);
        UIViewController *vc = [[myClass alloc]init];
        if (i!=(classNames.count-1)) {
            baseViewController *baseVC = (baseViewController *)vc;
            baseVC.catagory = arr[i];
        }
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [controlls addObject:nav];
        
    }
    self.viewControllers = controlls;
}

- (void)creatView{
    NSArray *imageNames = @[@"critic",@"novel",@"diagram",@"personal"];
    //按钮的宽度
    //CGFloat btnWidth = kScreenSize.width/imageNames.count;
    CGFloat space = (kScreenSize.width-40*4)/5;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenSize.height-44, kScreenSize.width, kScreenSize.height)];
    backgroundView.tag = 10;
    backgroundView.backgroundColor =[UIColor whiteColor];
    backgroundView.userInteractionEnabled =YES;
    for (NSInteger  i = 0; i<imageNames.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((40+space)*i+space,0, 40, 40);
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_%@",imageNames[i]]]forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage imageNamed:[NSString stringWithFormat:@"home_%@_focus",imageNames[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        button.tag = 101+i;
        [backgroundView addSubview:button];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(space,40, 40, 4)];
    label.backgroundColor = [UIColor grayColor];
    label.tag = 200;
    [backgroundView addSubview:label];
    [self.view addSubview:backgroundView];
    [self themeNotification];
}

- (void)btnClick:(UIButton*)sender{
    UILabel *label = (UILabel *)[self.view viewWithTag:200];
    CGRect fram = label.frame;
    fram.origin.x = sender.frame.origin.x;
    label.frame = fram;
    self.selectedIndex =sender.tag-101;
    
}

- (void)creatMyTabBar{
    self.tabBar.hidden = YES;
    [self creatCotrollers];
    [self creatView];
}

- (void)themeNotification{
    NSString * them =[[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    UIView *bottomBar = [self.view viewWithTag:10];
    if ([them boolValue]) {
       bottomBar.backgroundColor = kBlackColor;
    }else{
        bottomBar.backgroundColor = kWhiteColor;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
