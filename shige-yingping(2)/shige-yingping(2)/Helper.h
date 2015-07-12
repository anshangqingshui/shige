//
//  Helper.h
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+(double)getCurrentIOS;

+(NSString *)dateStringFromNumberTimer:(NSNumber *)timerNum;
+(CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;

@end
