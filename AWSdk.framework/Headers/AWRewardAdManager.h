//
//  AWRewardAdManager.h
//  TestAd
//
//  Created by lidong on 2019/5/31.
//  Copyright © 2019 lidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

typedef enum{
    eRewardAdNormalState,
    eRewardAdRequestingState,
    eRewardAdRequestSuccessState,
    eRewardAdRequestFailState,
    eRewardAdShowingSuccessState,
    eRewardAdShowingFailedState,
    eRewardAdCloseState,
}AWRewardAdState;

@protocol AWRewardAdManagerDelegate <NSObject>

@optional

-(void)rewardAdLoadSuccess;
-(void)rewardAdLoadFailedWithError;
-(void)rewardAdDidPresentScreen;
-(void)rewardAdDidDismissScreen;
-(void)rewardedAdDidEarnReward;

@end

typedef enum{
    eRewardAdLoadNormalState,
    eRewardAdLoadSuccessState,
    eRewardAdLoadFailedState,
    
    eRewardAdShowFailedState,
    eRewardAdDidPresentScreenState,
    eRewardedAdDidEarnRewardState,
    eRewardAdDidDismissScreenState
}AWRewardBlockState;

typedef void (^AWRewardAdBlock)(AWRewardBlockState state);


@interface AWRewardAdManager : NSObject{
//    AWRewardAdBlock _rewardRequestBlock;
//    AWRewardAdBlock _rewardBlock;
}

@property(nonatomic,retain)AWRewardAdBlock rewardRequestBlock;
@property(nonatomic,retain)AWRewardAdBlock rewardBlock;

@property(nonatomic,strong)NSString* rewardAdId;
@property(nonatomic, strong) GADRewardedAd *rewardedAd;
@property(nonatomic,assign)  AWRewardAdState currentState;
@property(nonatomic,weak,nullable)id<AWRewardAdManagerDelegate> delegate;


+(AWRewardAdManager*)sharedInstance;
-(void)preload;
-(void)preload:(AWRewardAdBlock)rewardAdBlock;

-(BOOL)isReady;
-(void)show;
-(void)showWithBlock:(AWRewardAdBlock)rewardAdBlock;
-(void)show:(UIViewController*)viewController;
-(void)showWithBlock:(AWRewardAdBlock)rewardAdBlock AndViewController:(UIViewController*)viewController;
@end

