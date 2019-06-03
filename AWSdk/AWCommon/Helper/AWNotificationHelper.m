//
//  NotificationHelper.m
//  7MinBut
//
//  Created by maning on 2017/12/28.
//  Copyright © 2017年 maning. All rights reserved.
//

#import "AWNotificationHelper.h"
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "AWSingleMacro.h"
#import "AWParamSettingHelp.h"

@import Firebase;

@interface AWNotificationHelper()<UNUserNotificationCenterDelegate>

@end

@implementation AWNotificationHelper

AW_SINGLETON_IMPL(AWNotificationHelper);

#pragma mark - 用户通知权限状态读取


- (BOOL)notificationServicesEnabled {
    BOOL isEnabled = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0f) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            return isEnabled;
        }else{
            return YES;
        }
    }
    return isEnabled;
}

-(BOOL)isAlreadyRegisterNotification{
    return AWGetBool(K_IS_ALREADY_RIGISTER_NOTIFICATION);
}
- (void)registerNotification{
    if ( [[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)] ) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:K_IS_ALREADY_RIGISTER_NOTIFICATION];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

-(void)registerPushNotifications{
    if ([UNUserNotificationCenter class] != nil) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
             // ...
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self checkNotificationServicesEnabled];
             });
         }];
    } else {
        UIApplication* app = [UIApplication sharedApplication];
        if([app respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            UIUserNotificationType allNotificationTypes =
            (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
            UIUserNotificationSettings *settings =
            [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
            [app registerUserNotificationSettings:settings];
        }
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:K_IS_ALREADY_RIGISTER_NOTIFICATION];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [FIRMessaging messaging].delegate = self;

    
}

-(void)checkNotificationServicesEnabled{
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 10.0) {
        if ([UNUserNotificationCenter class] != nil) {
            [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                if(settings.authorizationStatus == UNAuthorizationStatusAuthorized)
                {
                    self.isNotificationEnabled = YES;
                    NSLog(@"$!!Notification is enabled");
                }
                else
                {
                    self.isNotificationEnabled = NO;
                    NSLog(@"$!!Notification is disabled");
                }
            }];
        }
    } else {
        UIUserNotificationType notificationTypes = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
        if(notificationTypes == UIUserNotificationTypeNone){
            self.isNotificationEnabled = NO;
        }
        else{
            self.isNotificationEnabled = YES;
        }
    }
}

#pragma mark - 跳转系统设置页面
- (void)openNotificationSettings
{
    if (UIApplicationOpenSettingsURLString) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - 开启或关闭本地通知
- (void)openAlarmOrNot:(BOOL)isOpen
{
    if(isOpen){
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        NSCalendar* calendar = [NSCalendar currentCalendar];

        NSDate* now = [NSDate date];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:now];
        components.hour = self.alarmHour;
        components.minute = self.alarmMin;
        NSLog(@"%ld----%ld",components.hour,components.minute);
        UILocalNotification *notify=[[UILocalNotification alloc] init];

        if (notify != nil) {
            // 设置推送时间
            notify.fireDate = [calendar dateFromComponents:components];
            // 设置时区
            notify.timeZone = [NSTimeZone defaultTimeZone];
            // 设置重复间隔
            notify.repeatInterval = NSDayCalendarUnit;
            // 推送声音
            notify.soundName = /*self.notificationSoundName;*/UILocalNotificationDefaultSoundName;
            //APP左上角通知数量
            notify.applicationIconBadgeNumber= 1;
            // 推送内容
            notify.alertBody = self.title;

            notify.alertTitle = self.context;

            //设置userinfo 方便在之后需要撤销的时候使用
            //添加推送到UIApplication
            [[UIApplication sharedApplication] scheduleLocalNotification:notify];

        }
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

// The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"userInfo=%@",userInfo);
    
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    completionHandler(UNNotificationPresentationOptionNone);

}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
//    if (userInfo[kGCMMessageIDKey]) {
//        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
//    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler();
}


//// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
//    
//}
//
//// The method will be called on the delegate when the application is launched in response to the user's request to view in-app notification settings. Add UNAuthorizationOptionProvidesAppNotificationSettings as an option in requestAuthorizationWithOptions:completionHandler: to add a button to inline notification settings view and the notification settings view in Settings. The notification will be nil when opened from Settings.
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification {
//    
//}


@end
