//
//  AWFirebaseAnalytics.h
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWCommon.h"
@interface AWFirebaseAnalytics : NSObject

+(AWFirebaseAnalytics*)sharedInstance;

-(void)sendEvent:(NSString*)eventName andDict:(NSDictionary*)dict;

-(void)setUserPropertyString:(NSString*)propertyString forKey:(NSString*)key;

@end

