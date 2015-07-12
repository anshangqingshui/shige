//
//  define.h
//  shige-yinping
//
//  Created by qianfeng on 15-6-4.
//  Copyright (c) 2015年 牛鹏飞. All rights reserved.
//

#ifndef shige_yinping_define_h
#define shige_yinping_define_h
#define kScreenSize [UIScreen mainScreen].bounds.size

#define ImageURL @"http://images.shigeten.net/%@"

#define CriticURL @"http://api.shigeten.net/api/Critic/GetCriticList"
#define NovelURL @"http://api.shigeten.net/api/Novel/GetNovelList"
#define DiagramURL @"http://api.shigeten.net/api/Diagram/GetDiagramList"

#define CriticHomeURL @"http://api.shigeten.net/api/Critic/GetCriticContent?id=%d"
#define NovelHomeURL @"http://api.shigeten.net/api/Novel/GetNovelContent?id=%d"
#define DiagramHomeURL @"http://api.shigeten.net/api/Diagram/GetDiagramContent?id=%d"


#define ShareURL @"http://www.shigeten.net/content.aspx?type=%d&id=%d"

#define kPrint  NSLog(@"%s",__func__);

//夜间模式下的背景颜色
#define kBackeColor [UIColor colorWithRed:1 green:1  blue:1 alpha:0.5];
#define kCellBlackColor [UIColor colorWithRed:0 green:0  blue:0 alpha:0.3];
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor];

//更主题的通知
#define kThemeDidChangeNotification @"kThemeDidChangeNotification"
//是否是默认(白天)模式 白天值默认为0 夜间默认为1
#define kThemeName @"TemeName"

#endif
