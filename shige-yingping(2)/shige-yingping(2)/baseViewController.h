//
//  baseViewController.h
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"
#import "headView.h"
#import "FootView.h"


@interface baseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableDictionary *_dataDict;
    NSMutableArray *_dataArr;
    NSMutableArray *_markArr;//首次标记数组
    AFHTTPRequestOperationManager *_manager;
}

@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *markArr;


//滚动视图的所有数据
//@property (nonatomic,strong)NSMutableArray *allData;

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *controllerArr;
//十个数据的滚动的下标
@property (nonatomic,assign)int index;
//标记类
@property (nonatomic,copy)NSString *catagory;


- (void)loadDownHomeWithURL:(NSString *)url withOther:(NSString *)otherUrl;
- (void)loadDownWithURL:(NSString *)url index:(int)indexL;

@end
