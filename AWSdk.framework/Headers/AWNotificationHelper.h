//
//  NotificationHelper.h
//  7MinBut
//
//  Created by maning on 2017/12/28.
//  Copyright © 2017年 maning. All rights reserved.
//

#import <Foundation/Foundation.h>

#define K_IS_ALREADY_RIGISTER_NOTIFICATION @"K_IS_ALREADY_RIGISTER_NOTIFICATION"

@interface AWNotificationHelper : NSObject

//设定本地通知音频文件名称（音频文件格式限定是 aiff，wav，caf 文件，文件也必须放到app的 mainBundle 目录中）
@property(nonatomic,strong) NSString *notificationSoundName;
//设定本地通时间（小时）
@property(nonatomic,assign) NSInteger alarmHour;
//设定本地通时间（分钟）
@property(nonatomic,assign) NSInteger alarmMin;

@property(nonatomic,strong) NSString* title;

@property(nonatomic,strong) NSString* context;

@property(nonatomic,assign)BOOL isNotificationEnabled;


+ (AWNotificationHelper*)sharedInstance;

//用户通知权限状态读取
- (BOOL)notificationServicesEnabled;
- (void)registerNotification;  //弹 native 通知权限框，一个版本号只弹一次
-(BOOL)isAlreadyRegisterNotification;
//跳转系统设置页面
- (void)openNotificationSettings;
//开启或关闭本地通知
- (void)openAlarmOrNot:(BOOL)isOpen;

-(void)registerPushNotifications;

@end
