//
//  AWFirebaseAnalytics.m
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWFirebaseAnalytics.h"
@import Firebase;


@implementation AWFirebaseAnalytics

AW_SINGLETON_IMPL(AWFirebaseAnalytics);

- (instancetype)init
{
    self = [super init];
    if (self) {
   
    }
    return self;
}

-(void)sendEvent:(NSString*)eventName andDict:(NSDictionary*)dict{
    [FIRAnalytics logEventWithName:eventName
                        parameters:dict];
}

-(void)setUserPropertyString:(NSString*)propertyString forKey:(NSString*)key{
    [FIRAnalytics setUserPropertyString:propertyString forName:key];
}


@end
