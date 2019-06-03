//
//  ExceptionHelp.h
//  yoga
//
//  Created by lidong on 2019/3/27.
//  Copyright © 2019 fitness.workouts.beginners. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AWExceptionHelp : NSObject

+(void)throwException:(NSString*)name reason:(nullable NSString*)reason userInfo:(nullable NSDictionary *)userInfo;

@end

