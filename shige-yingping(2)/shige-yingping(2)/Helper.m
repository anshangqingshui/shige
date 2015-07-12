//
//  Helper.m
//  shige-yingping(2)
//
//  Created by qianfeng on 15-6-8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+(NSString *)dateStringFromNumberTimer:(NSNumber *)timerNum{
    double t = [timerNum intValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy.MM.dd";
    NSDate *str = [formatter dateFromString:@"2015.06.11"];
    NSTimeInterval interval =  [str timeIntervalSince1970];
    return [formatter stringFromDate:date];
}

+(CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    if ([Helper getCurrentIOS]>=7.0) {
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        return rect.size.height;
    }else{
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(textWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        return textSize.height;
    }
}


+(double)getCurrentIOS{
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

@end
