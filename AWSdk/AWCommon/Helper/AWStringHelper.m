//
//  StringHelper.m
//  7minCardio
//
//  Created by lidong on 2019/5/15.
//  Copyright © 2019 maning. All rights reserved.
//

#import "AWStringHelper.h"

@implementation AWStringHelper

+ (NSString*)getDateStringWithDate:(NSDate*)date //本地日期
{
    if(nil == date)
        return @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



+(NSString*)getTimeStringWithSecond:(int)second{
    int minute = second/60;
    NSString* minuteStr=@"";
    if(minute>=10){
        minuteStr  = [NSString stringWithFormat:@"%d",minute];
    }
    else{
        minuteStr  = [NSString stringWithFormat:@"0%d",minute];
    }
    
    int remindSec = second%60;
    NSString* secondStr=@"";
    if(remindSec>=10){
        secondStr = [NSString stringWithFormat:@"%d",remindSec];
    }
    else{
        secondStr = [NSString stringWithFormat:@"0%d",remindSec];
    }
    
    return [NSString stringWithFormat:@"%@:%@",minuteStr,secondStr];
}

@end
