//
//  AWSdk.h
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

/*

 Firebase analystic
 
 在 Xcode 中，依次选择 Product > Scheme > Edit scheme...。
 从左侧菜单中选择 Run。
 选择 Arguments 标签。
 在 Arguments Passed On Launch 部分中，添加 -FIRAnalyticsDebugEnabled。

 firebase Crashlytics
 在 Xcode 中打开您的项目，然后在 Navigator 中选择其项目文件。
 从 Select a project or target 下拉菜单中选择您的主要编译目标。
 打开该目标的 Build Phases 标签。
 点击 + Add a new build phase，然后选择 New Run Script Phase。

 将下面这行代码添加到 Type a script 文本框中：
 CocoaPods 安装
 "${PODS_ROOT}/Fabric/run"
 
*/
#import <Foundation/Foundation.h>

#import "AWCommon/AWCommon.h"
#import "AdSdk/AdSdk.h"
#import "AWFirebase/AWFirebase.h"


typedef enum{
    AWBannerType,
    AWRectType,
    AWInterstitialType,
    AWRewardType
}AWAdType;

typedef enum{
    eAdInterstitialLoadSuccessState,
    eAdInterstitialLoadFaildedState,
    
    eAdInterstitialShowWillPresentScreen,
    eAdInterstitialShowFailToPresentScreen,
    eAdInterstitialShowWillDismissScreen,
    eAdInterstitialShowDidDismissScreen,
    eAdInterstitialShowClickWillLeaveApplication,
    
    eAdRewardLoadSuccessState,
    eAdRewardLoadFailedState,
    
    eAdRewardShowFailed,
    eAdRewardShowDidPresentScreen,
    eAdRewardShowDidEarnReward,
    eAdRewardShowDismissScreen

} AWAdState;


typedef void (^AWAdBlock)(AWAdType adType,AWAdState sdState);


@interface AWSdk : NSObject{
    
}

@property(nonatomic,retain)AWAdBlock preloadFullAdBlock;
@property(nonatomic,retain)AWAdBlock preloadRewardAdBlock;
@property(nonatomic,retain)AWAdBlock fullAdBlock;
@property(nonatomic,retain)AWAdBlock rewardAdBlock;

+(AWSdk*)sharedInstance;

-(void)showAd:(AWAdType)type;

-(void)showAd:(AWAdType)type andBlock:(AWAdBlock)adBlock;

-(UIView*)getRectContainerView;

-(void)removeBanner;

-(void)preloadAd;

-(void)preloadAdWithType:(AWAdType)type WithBlock:(AWAdBlock)adBlock;

@end

