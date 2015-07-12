//
//  NovelViewController.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NovelViewController.h"
#import "NovelCell.h"



@interface NovelViewController ()
@end

@implementation NovelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 80,40)];
    label.text =@"文章";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:label];
    self.navigationItem.leftBarButtonItem = item;
        
    [self loadDownHomeWithURL:NovelURL withOther:NovelHomeURL];
}

- (void)registerNib:(UITableView*)tableView{
    [tableView registerNib:[UINib nibWithNibName:@"NovelCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat Height = 10;
       UIImage *image = nil;
   // if (self.dataDict) {
        if ([self.delegate respondsToSelector:@selector(sendImageData:)]) {
            image =[self.delegate sendImageData:self.dataDict];
          //  Height+=((image.size.height/image.size.width)*(kScreenSize.width-20)+10);
        }
   // }
    
    if(self.dataDict[@"summary"]){
        Height += ([Helper textHeightFromTextString:self.dataDict[@"summary"] width:(kScreenSize.width-30) fontSize:14]+10);
    }
    Height+=10;
    Height+= [Helper textHeightFromTextString:self.dataDict[@"text"] width:(kScreenSize.width-30) fontSize:14];

    return Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NovelCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [Cell showDataWithModel:self.dataArr[indexPath.row]withKey:@"image"];
     Cell.selectionStyle = UITableViewCellEditingStyleNone;
    return Cell;
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
