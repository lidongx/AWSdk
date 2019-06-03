//
//  AWFirebaseManager.m
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWFirebaseManager.h"
#import "AWHelper.h"
#import "AWFirebaseFCM.h"
@import Firebase;

@implementation AWFirebaseManager

AW_SINGLETON_IMPL(AWFirebaseManager);

- (instancetype)init
{
    self = [super init];
    if (self) {
        if([FIRApp defaultApp]==nil){
            [FIRApp configure];
        }

//        [[AWNotificationHelper sharedInstance] registerPushNotifications];
        [AWFirebaseFCM sharedInstance];
        
    }
    return self;
}


@end
