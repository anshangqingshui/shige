//
//  CriticViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CriticViewController.h"
#import "CriticCell.h"


@interface CriticViewController ()


@end

@implementation CriticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDownHomeWithURL:CriticURL withOther:self.catagory];
    UIImageView *item = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    item.image =[UIImage imageNamed:@"icon"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:item];
}

- (void)preperData{
    NSDictionary *dict1 = [[NSDictionary alloc]initWithObjectsAndKeys:self.dataDict[@"text1"],@"text",self.dataDict[@"image1"],@"image",nil];
    [self.dataArr addObject:dict1];
    NSDictionary *dict2 = [[NSDictionary alloc]initWithObjectsAndKeys:self.dataDict[@"text2"],@"text",self.dataDict[@"image2"],@"image",nil];
    [self.dataArr addObject:dict2];
    NSDictionary *dict3 = [[NSDictionary alloc]initWithObjectsAndKeys:self.dataDict[@"text3"],@"text",self.dataDict[@"image3"],@"image",nil];
    [self.dataArr addObject:dict3];
    NSDictionary *dict4 = [[NSDictionary alloc]initWithObjectsAndKeys:self.dataDict[@"text4"],@"text",self.dataDict[@"image4"],@"image",nil];
    [self.dataArr addObject:dict4];
    NSDictionary *dict5 = [[NSDictionary alloc]initWithObjectsAndKeys:self.dataDict[@"text5"],@"text",@"",@"image",nil];
    [self.dataArr addObject:dict5];
    self.index = (int)(self.scrollView.contentOffset.x/kScreenSize.width);
    UITableView *tableView = self.controllerArr[self.index];
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerNib:(UITableView*)tableView{
    [tableView registerNib:[UINib nibWithNibName:@"CriticCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArr[indexPath.row];
    CGFloat height = [Helper textHeightFromTextString:dict[@"text"] width:(kScreenSize.width-20) fontSize:14]+30;
    if (![dict[@"image"] isEqualToString:@""]) {
        height += 160;
    }
    return height;
}
- (CriticCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CriticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithModel:model];
   
    return cell;
}


@end
