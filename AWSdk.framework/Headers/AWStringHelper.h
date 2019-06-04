//
//  StringHelper.h
//  7minCardio
//
//  Created by lidong on 2019/5/15.
//  Copyright © 2019 maning. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface AWStringHelper : NSObject

+ (NSString*)getDateStringWithDate:(NSDate*)date ;

+(NSString*)getTimeStringWithSecond:(int)second;

@end

NS_ASSUME_NONNULL_END
