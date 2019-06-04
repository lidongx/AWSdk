//
//  AWFirebaseManager.h
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWCommon.h"
#import "AWFirebaseAnalytics.h"


#define AWSendEvent(eventName,dict) [[AWFirebaseAnalytics sharedInstance] sendEvent:eventName andDict:dict];

#define AWSetUserProperty(key,strValue) [[AWFirebaseAnalytics sharedInstance] setUserPropertyString:key forKey:strValue];

#define FIREBASE_lOG CLS_LOG(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd))
#define FIREBASE_lOG_STR(...) CLS_LOG(@"%@:%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),## __VA_ARGS__)


@interface AWFirebaseManager : NSObject

+(AWFirebaseManager*)sharedInstance;

@end

