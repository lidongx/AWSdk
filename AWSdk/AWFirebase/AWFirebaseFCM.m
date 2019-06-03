//
//  AWFirebaseFCM.m
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWFirebaseFCM.h"
#import "AWCommon.h"
@import Firebase;

@interface AWFirebaseFCM()<FIRMessagingDelegate>



@end

@implementation AWFirebaseFCM

AW_SINGLETON_IMPL(AWFirebaseFCM);

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [FIRMessaging messaging].delegate = self;

        [[FIRInstanceID instanceID] instanceIDWithHandler:^(FIRInstanceIDResult * _Nullable result,
                                                            NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"Error fetching remote instance ID: %@", error);
            } else {
                NSLog(@"Remote instance ID token: %@", result.token);
      
            }
        }];
        
    }
    return self;
}

#pragma mark - FIRMessagingDelegate
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken
{
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
    // Note: 该代理等同于侦听名为 kFIRMessagingRegistrationTokenRefreshNotification 的 NSNotification
    NSLog(@"FCM registration token: %@", fcmToken);
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FCMToken" object:nil userInfo:dataDict];
}

- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage
{
    //在应用于前台运行时直接从 FCM（而不是通过 APNs）接收仅包含数据的消息
    
    /*向设备组发送上行消息(如果您的应用服务器实现了 XMPP 连接服务器协议，则可接收从用户设备发送至云端的上行消息。)*/
    //[[FIRMessaging messaging] sendMessage:@"messageDic" to:@"receiver" withMessageID:@"messageID" timeToLive:64];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendDataMessageFailure:) name:FIRMessagingSendErrorNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendDataMessageSuccess:) name:FIRMessagingSendSuccessNotification object:nil];
}


@end
