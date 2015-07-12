//
//  DiagramViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DiagramViewController.h"
#import "NovelCell.h"


@interface DiagramViewController ()

@end

@implementation DiagramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 80,40)];
    label.text =@"美图";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:label];
    self.navigationItem.leftBarButtonItem = item;
    [self loadDownHomeWithURL:DiagramURL withOther:DiagramHomeURL];
}

- (void)registerNib:(UITableView*)tableView{
    [tableView registerNib:[UINib nibWithNibName:@"NovelCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NovelCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   
    [Cell showDataWithModel:self.dataArr[indexPath.row]withKey:@"image1"];
    Cell.selectionStyle = UITableViewCellEditingStyleNone;
    return Cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenSize.height;
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
