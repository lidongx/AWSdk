//
//  DateHelper.h
//  7minCardio
//
//  Created by lidong on 2019/5/14.
//  Copyright © 2019 maning. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AWDateHelper : NSObject

+ (NSDate*)getDateByString:(NSString*)dateString;
+ (NSDate *)getLocalDate:(NSDate*)utcDate;
+(NSDate*)getDateOfSystemZone:(NSDate*)pUtcDate;
+(NSDate*)getTimeDisDate:(NSDate*)pDate;

@end




