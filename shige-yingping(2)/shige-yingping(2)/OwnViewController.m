//
//  OwnViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "OwnViewController.h"
#import "settingCell.h"

@interface OwnViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation OwnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self creatTableView];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 44)];
    label.text = @"个人中心";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:label];
    self.navigationItem.leftBarButtonItem = item;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification) name:kThemeDidChangeNotification object:nil];
    [self setThemColor];
    
}
- (void)setThemColor{
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if (![them boolValue]||them==nil) {
        self.tableView.backgroundColor = kWhiteColor;
    }else{
        self.tableView.backgroundColor = kBackeColor;
    }
}


- (void)themeNotification{
    NSString * them =[[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if ([them boolValue]) {
        self.tableView.backgroundColor = kBackeColor;
    }else{
        self.tableView.backgroundColor = kWhiteColor;
   }
}

- (void)creatTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenSize.width,(kScreenSize.height-64-45)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"settingCell" bundle:nil] forCellReuseIdentifier:@"settingCell"];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 45;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tabBarController hidesBottomBarWhenPushed];
}

- (void)initData{
    self.dataArray = [[NSMutableArray alloc]init];
    NSArray *titles = @[@"我的收藏",@"设置",@"关于十个",@"意见反馈"];
    NSArray *images = @[@"setting_favorite",@"setting_font",@"setting_aboutus",@"setting_feedback"];
    NSArray *classNames =@[@"CollectViewController",@"SettingViewController",@"AboutViewController",@"IdeaViewController"];
    for (NSInteger i = 0; i<titles.count; i++) {
        NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:titles[i],@"text",images[i],@"image",classNames[i],@"className",nil];
        [self.dataArray addObject:dict];
    }
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArray[indexPath.row];
    Class myClass = NSClassFromString(dict[@"className"]);
    UIViewController *vc = [[myClass alloc]init];
    [self setNavigationItem:vc withindex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    //隐藏bar
    UIView* bar = [self.tabBarController.view viewWithTag:10];
    bar.hidden = YES;

}
- (void)setNavigationItem:(UIViewController *)vc withindex:(NSInteger)index{
    NSArray *title = @[@"收藏",@"设置",@"关于我们",@"意见反馈"];
    //设置导航栏的返回按钮
    UIView *backButton = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    UIImageView *itemImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    itemImage.image =[UIImage imageNamed:@"back"];
    itemImage.userInteractionEnabled =YES;
    [backButton addSubview:itemImage];
    UILabel *itemLabel =[[UILabel alloc]initWithFrame:CGRectMake(44, 0, 100, 40)];
    itemLabel.text = title[index];
    itemLabel.userInteractionEnabled = YES;
    [backButton addSubview:itemLabel];
    backButton.userInteractionEnabled =YES;
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:vc action:@selector(TapGestureClick)];
    [backButton addGestureRecognizer:tap];
    
    UIBarButtonItem *item =[[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    vc.navigationItem.leftBarButtonItem = item;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    settingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    [cell showDataWithModel:dict];
    cell.backgroundColor = kBackeColor;
    return cell;
}
- (void)viewWillAppear:(BOOL)animated{
    UIView* bar = [self.tabBarController.view viewWithTag:10];
    bar.hidden = NO;
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
