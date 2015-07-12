//
//  NovelViewController.h
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "baseViewController.h"

@protocol NovelDelegate <NSObject>

//- (UIImage *)sendImageData:(NSDictionary*)model withKey:(NSString *)key;
- (UIImage *)sendImageData:(NSDictionary *)model;
@end

@interface NovelViewController : baseViewController
@property(nonatomic,weak)id<NovelDelegate>delegate;
@end
