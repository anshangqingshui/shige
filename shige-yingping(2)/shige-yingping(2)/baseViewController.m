//
//  baseViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "baseViewController.h"
#import "UMSocial.h"
#import "NSString+Hashing.h"


@interface baseViewController ()<HeadViewDelegate,UMSocialUIDelegate>
{
    NSMutableArray *_controllerArr;
}
@property (nonatomic,assign)CGRect headViewfram;
@property (nonatomic,assign)NSInteger arrIndex;
@end

@implementation baseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customUI];
    
}


- (void)customUI{
    [self creatScrollView];
    [self creatHttpRequset];
}

- (void)creatScrollView{
    self.arrIndex = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.controllerArr  = [[NSMutableArray alloc]init];
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate =self;
    for (NSInteger i = 0; i<10; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenSize.width*i,64, kScreenSize.width, kScreenSize.height-64-45)];
        tableView.delegate = self;
        tableView.dataSource = self;
        //  tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self creatHeadView:tableView];
        [self creatFootView:tableView];
        self.headViewfram = tableView.tableHeaderView.frame;
        [self creatImageView:tableView];
        [self registerNib:tableView];
        [self.scrollView addSubview:tableView];
        [self.controllerArr addObject:tableView];
        }
    self.scrollView.contentSize = CGSizeMake(kScreenSize.width*10, kScreenSize.height);
    [self.view addSubview:self.scrollView];
}




//添加网络请求
- (void)creatHttpRequset{
    //self.allData = [[NSMutableArray alloc]init];
    self.dataArr = [[NSMutableArray alloc]init];
    self.dataDict = [[NSMutableDictionary alloc]init];
    self.markArr = [[NSMutableArray alloc]init];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

- (void)loadDownHomeWithURL:(NSString *)url withOther:(NSString *)otherUrl{
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (self.markArr.count!=0) {
            [self.markArr removeAllObjects];
        }
        [self.markArr addObjectsFromArray:dict[@"result"]];
       // NSLog(@"%@",self.markArr);
        [self loadDownWithURL:otherUrl index:0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@下载失败",[self class]);
    }];
}

- (void)loadDownWithURL:(NSString *)url index:(int)indexL{
    NSDictionary *dict = self.markArr[indexL];
    NSString *pathUrl = [NSString stringWithFormat:url,[dict[@"id"] intValue]];
    
    [_manager GET:pathUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.dataDict setValuesForKeysWithDictionary:dict];
        [self preperData];
        UITableView *tableView = self.controllerArr[indexL];
        UIImageView *loadImageView = (UIImageView *)[tableView viewWithTag:300];
        [loadImageView stopAnimating];
        loadImageView.animationImages = nil;
        [tableView reloadData];
        headView *head = (headView *)tableView.tableHeaderView;
        [head showViewWithModel:self.dataDict];
        FootView *foot = (FootView *)tableView.tableFooterView;
        [foot showDataWithModel:self.dataDict];
        [self setFootViewHeight:foot];
        [self setFrameForHeadView:head withView:tableView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@下载失败",[self class]);
    }];

}

#pragma mark 添加头视图
- (void)creatHeadView:(UITableView *)tableView{
    headView *head =[[[NSBundle mainBundle]loadNibNamed:@"headView" owner:self options:nil]lastObject];
    head.delegate = self;
    [tableView setTableHeaderView:head];
}


- (void)setFrameForHeadView:(UIView*)head withView:(UITableView *)tableView{
    if (!self.dataDict[@"imageforplay"]) {
        CGRect frame = self.headViewfram;
        frame.size.height -=150;
        head.frame = frame;
        [tableView setTableHeaderView:head];
    }else{
        return;
    }
}

#pragma mark 头视图的方法
- (void)sendEvetent:(UIButton *)btn{
    if([self.view viewWithTag:20]==nil){
        [self creatShareView];
    }
    UIView *shareView = [self.view viewWithTag:20];
    UILabel *label =(UILabel *)[shareView viewWithTag:1];
    if ([self NovelIsExit]==YES) {
        label.text = @"已收藏";
    }else{
        label.text = @"收藏";
    }
   
    if (btn.selected == NO) {
         CGRect fram = CGRectMake(0, kScreenSize.height/2, kScreenSize.width, kScreenSize.height/2);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        shareView.frame = fram;
        [UIView commitAnimations];
        
    }else{
        CGRect fram = CGRectMake(0, kScreenSize.height, kScreenSize.width, kScreenSize.height/2);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        shareView.frame = fram;
        [UIView commitAnimations];
    }
}

- (void)creatShareView{
    UIView *shareView = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenSize.height, kScreenSize.width, kScreenSize.height/2)];
    shareView.backgroundColor = [UIColor whiteColor];
    shareView.userInteractionEnabled = YES;
    shareView.tag = 20;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0,kScreenSize.width, 21)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"希望将此文";
    [shareView addSubview:label];
    NSArray *btnArray = @[@"share_favorite",@"share_weixin",@"share_pengyouquan",@"share_weibo",@"share_qq_bound",@"share_qqzone_bound"];
    NSArray *titleArray = @[@"收藏",@"微信好友",@"微信朋友圈",@"新浪微博",@"手机QQ",@"QQ空间"];
    int row = 0;int col = 0;
    CGFloat space = (kScreenSize.width-60*3)/4;
    for (NSInteger i = 0 ; i<titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        row = (int)i/3;
        col = i%3;
        button.frame = CGRectMake((space +60)*col+space, (60+20)*row+30, 60, 50);
        [button setImage:[UIImage imageNamed:btnArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnShareClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 301+i;
        [shareView addSubview:button];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+button.frame.size.height, 60, 20)];
        if (i==0) {
            label.tag = 1;
        }
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [shareView addSubview:label];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 190, kScreenSize.width-40, 20);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:button];
    [self.view addSubview:shareView];
}


- (void)cancelBtnClick{
    UIView *view =  [self.view viewWithTag:20];
    CGRect fram = view.frame;
    fram.origin.y +=(kScreenSize.height/2);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    view.frame  = fram;
    [UIView commitAnimations];
}

- (void)btnShareClick:(UIButton *)sender{
    NSDictionary *dict = self.markArr[self.arrIndex];
    NSString *Lasturl = [[NSString alloc]initWithFormat:ShareURL,[dict[@"type"] intValue],[dict[@"id"] intValue]];
    switch (sender.tag) {
        case 301:{//收藏
            //[self.dataDict writeToFile:filePath atomically:nil];
            [self shareFavorite];
        }
            break;
        case 302:{//微信
            NSString *url = [[NSString alloc]initWithFormat:@"%@ %@",self.dataDict[@"title"],Lasturl];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:url image:[UIImage imageNamed:@"icon"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            [UMSocialData defaultData].extConfig.wechatSessionData.url = Lasturl;
            //微信朋友圈
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"欢迎阅读十个影评";
        }
            break;
        case 303:{//好友圈
        }
            break;
        case 304:{//新浪微博
           
            
            /*[[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:Lasturl];
            [UMSocialData defaultData].shareText = self.dataDict[@"title"];
            [UMSocialData defaultData].shareImage = [UIImage imageNamed:@"icon"] ;
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:@"sina"];
            snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);*/
            
           UMSocialUrlResource *resource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:Lasturl];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:self.dataDict[@"title"] image:[UIImage imageNamed:@"icon.png"] location:nil urlResource:resource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
            
        }
            break;
        case 305:{
        }
        case 306:{
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"分享文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];

        }
            
        default:
            break;
    }
}



#pragma mark 添加尾视图
- (void)creatFootView:(UITableView *)tableView{
    FootView *footView =[[FootView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 60)];
    [tableView setTableFooterView:footView];
}

- (void)setFootViewHeight:(FootView *)foot{
    CGRect frame =foot.frame;
    frame.size.height = [Helper textHeightFromTextString:self.dataDict[@"author"] width:(kScreenSize.width - 20) fontSize:14]+25;
    foot.frame = frame;
}

#pragma mark 添加加载前的动画效果
- (void)creatImageView:(UITableView *)tableView{
   UIImageView * loadImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenSize.width-50)/2, (kScreenSize.height-50-64-45)/2, 50, 50)];
    loadImageView.tag = 300;
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i<=14; i++) {
        [images addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"loading_%d",(int)i] ofType:@"png"]]];
    }
    loadImageView.animationImages = images;
    loadImageView.animationDuration = 1;
    loadImageView.animationRepeatCount = 0;
    [tableView addSubview:loadImageView];
    [loadImageView startAnimating];
    
}
//子类需要重写的类
- (void)registerNib:(UITableView*)tableView{
}


- (void)preperData{
    [self.dataArr addObject:self.dataDict];
}


#pragma mark- tableView协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)setThemColor:(UITableView *)view{
    NSString *them = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    if (![them boolValue]||them==nil) {
        view.backgroundColor = kWhiteColor;
    }else{
        view.backgroundColor = kBackeColor;
    }
}
#pragma mark ScrollerViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    [self cancelBtnClick];
    
    self.arrIndex = self.scrollView.contentOffset.x/kScreenSize.width;
}

#pragma mark -scrollView的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if([scrollView isKindOfClass:[UITableView class]]){
        return;
    }
    if (_dataArr) {
        [_dataArr removeAllObjects];
    }
    int index = (int)(self.scrollView.contentOffset.x/kScreenSize.width);
    [self loadDownWithURL:self.catagory index:index];
}


#pragma mark 分享事件
- (void)shareFavorite{
    NSMutableArray *fileArr = [[NSMutableArray alloc]initWithContentsOfFile:[self getFilePath]];
    
    UIView *shareView = [self.view viewWithTag:20];
    UILabel *label = (UILabel *)[shareView viewWithTag:1];
    NSMutableDictionary *saveDict = [[NSMutableDictionary alloc]initWithDictionary:self.dataDict];
    for (NSDictionary *dict in self.markArr) {
        if ([dict[@"id"] intValue ]== [self.dataDict[@"id"] intValue]) {
          [saveDict addEntriesFromDictionary:dict];
        }
    }
    if ([label.text isEqualToString:@"已收藏"]) {
        [fileArr removeObject:saveDict];
        
        //NSLog(@"fileArr");
        label.text = @"收藏";
    }else{
        [fileArr addObject:saveDict];
        label.text = @"已收藏";
    }
    
    [fileArr writeToFile:[self getFilePath] atomically:YES];
}
//检查文章是已收藏
- (BOOL)NovelIsExit{
    NSArray *fileArr = [[NSArray alloc]initWithContentsOfFile:[self getFilePath]];
    for (NSDictionary *dict in fileArr) {
        if ([dict[@"id"] intValue ]== [self.dataDict[@"id"] intValue]) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

- (NSString *)getFilePath{
    NSString *DocmentsPath = [NSHomeDirectory()stringByAppendingString:@"/Documents/"];
    NSString *fileName =@"MyFavorite.json";
   //fileName = [fileName MD5Hash];
    NSLog(@"%@",[DocmentsPath stringByAppendingString:fileName]);
   return [DocmentsPath stringByAppendingString:fileName];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
