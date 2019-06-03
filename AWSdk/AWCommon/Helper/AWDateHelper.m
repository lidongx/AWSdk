//
//  DateHelper.m
//  7minCardio
//
//  Created by lidong on 2019/5/14.
//  Copyright © 2019 maning. All rights reserved.
//

#import "AWDateHelper.h"
#import "AWSingleMacro.h"
@implementation AWDateHelper

AW_SINGLETON_IMPL(AWDateHelper);


+ (NSDate*)getDateByString:(NSString*)dateString
{
    if(0 == dateString.length)
        return nil;
    
    NSArray* array = [dateString componentsSeparatedByString:@" "];
    if([array count])
        dateString = array[0];
    if(0 == dateString.length)
        return nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    //    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    return [dateFormatter dateFromString:dateString];
}

+ (NSDate *)getLocalDate:(NSDate*)utcDate
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: utcDate];
    return [NSDate dateWithTimeInterval: seconds sinceDate: utcDate];
}

+(NSDate*)getDateOfSystemZone:(NSDate*)pUtcDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [zone secondsFromGMTForDate:pUtcDate];
    return [pUtcDate dateByAddingTimeInterval:interval];
}


+(NSDate*)getTimeDisDate:(NSDate*)pDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //系统时区与GMT 之间的时间差
    NSTimeInterval interval = [zone secondsFromGMTForDate:pDate];
    return [pDate dateByAddingTimeInterval:-interval];
}




@end
