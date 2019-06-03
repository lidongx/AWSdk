//
//  ExceptionHelp.m
//  yoga
//
//  Created by lidong on 2019/3/27.
//  Copyright © 2019 fitness.workouts.beginners. All rights reserved.
//

#import "AWExceptionHelp.h"

@implementation AWExceptionHelp

+(void)throwException:(NSString*)name reason:(nullable NSString*)reason userInfo:(nullable NSDictionary *)userInfo{
    if(reason!=nil){
        NSLog(@"---error:%@:%@",name,reason);
    }
    else{
          NSLog(@"---error:%@",name);
    }
    
#ifdef DEBUG
    NSAssert(false, name, reason);
    @throw [NSException exceptionWithName:name reason:reason userInfo:userInfo];
#endif
}

@end
