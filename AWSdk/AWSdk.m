//
//  AWSdk.m
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWSdk.h"

@implementation AWSdk

AW_SINGLETON_IMPL(AWSdk);

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [AWFirebaseManager sharedInstance];
        
        [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
        [GADMobileAds sharedInstance].applicationVolume =  0.0f;
       
    }
    return self;
}

-(void)preloadAd{
    [[AWBannerAdManager sharedInstance] preload];
    [[AWRectAdManager sharedInstance] preload];
    [[AWInterstitialAdManager sharedInstance] preload];
    [[AWRewardAdManager sharedInstance] preload];
}

-(void)preloadAdWithType:(AWAdType)type WithBlock:(AWAdBlock)adBlock{
    switch (type) {
        case AWInterstitialType:
        {
            self.preloadFullAdBlock = adBlock;
            if(self.preloadFullAdBlock==nil){
                return;
            }
            
            [[AWInterstitialAdManager sharedInstance] preload:^(AWInterstitialBlockState state) {
                switch (state) {
                    case eInterstitialAdLoadSuccessState:
                    {
                         self.preloadFullAdBlock (type,eAdInterstitialLoadSuccessState);
                    }
                        break;
                    case eInterstitialAdLoadFailedState:
                    {
                          self.preloadFullAdBlock (type,eAdInterstitialLoadFaildedState);
                    }
                        break;
                    default:
                        break;
                }
            }];
        }
            break;
        case AWRewardType:
        {
            self.preloadRewardAdBlock = adBlock;
            if(self.preloadRewardAdBlock==nil){
                return;
            }
            [[AWRewardAdManager sharedInstance] preload:^(AWRewardBlockState state) {
                switch (state) {
                    case eRewardAdLoadSuccessState:
                    {
                        self.preloadRewardAdBlock(type,eAdRewardLoadSuccessState);
                    }
                        break;
                    case eRewardAdLoadFailedState:
                    {
                        self.preloadRewardAdBlock(type,eAdRewardLoadFailedState);
                    }
                        break;
                    default:
                        break;
                }
            }];
        }
            break;
        default:
            break;
    }
}


-(void)showAd:(AWAdType)type{
    switch (type) {
        case AWBannerType:
        {
            [[AWBannerAdManager sharedInstance] show];
        }
            break;
        case AWInterstitialType:
        {
            [[AWInterstitialAdManager sharedInstance] show];
        }
            break;
            
        case AWRewardType:{
            [[AWRewardAdManager sharedInstance] show];
        }
            
        default:
            break;
    }
}

-(void)showAd:(AWAdType)type andBlock:(AWAdBlock)adBlock{

    switch (type) {
        case AWInterstitialType:
        {
            self.fullAdBlock = adBlock;
            if(self.fullAdBlock == nil){
                return;
            }
            [[AWInterstitialAdManager sharedInstance] showWithBlock:^(AWInterstitialBlockState state) {
                switch (state) {
                    case eInterstitialAdShowWillPresentScreen:
                    {
                        self.fullAdBlock(type,eAdInterstitialShowWillPresentScreen);
                    }
                        break;
                        
                    case eInterstitialAdShowDidFailToPresentScreen:
                    {
                        self.fullAdBlock(type,eAdInterstitialShowFailToPresentScreen);
                    }
                        break;
                        
                    case eInterstitialAdWillDismissScreen:
                    {
                        self.fullAdBlock(type,eAdInterstitialShowWillDismissScreen);
                    }
                        break;
                    case eInterstitialAdDidDismissScreen:
                    {
                        self.fullAdBlock(type,eAdInterstitialShowDidDismissScreen);
                    }
                        break;
                        
                    case eInterstitialAdClickWillLeaveApplication:
                    {
                        self.fullAdBlock(type,eAdInterstitialShowClickWillLeaveApplication);
                    }
                        break;
                    default:
                        break;
                }
            }];
        }
            break;
        case AWRewardType:{
            self.rewardAdBlock = adBlock;
            if(self.rewardAdBlock==nil){
                return;
            }
            [[AWRewardAdManager sharedInstance] showWithBlock:^(AWRewardBlockState state) {
                switch (state) {
                    case eRewardAdShowFailedState:
                    {
                        self.rewardAdBlock(type,eAdRewardShowFailed);
                    }
                        break;
                    case eRewardAdDidPresentScreenState:
                    {
                        self.rewardAdBlock(type,eAdRewardShowDidPresentScreen);
                    }
                        break;
                    case eRewardedAdDidEarnRewardState:
                    {
                        self.rewardAdBlock(type,eAdRewardShowDidEarnReward);
                    }
                        break;
                    case eRewardAdDidDismissScreenState:
                    {
                        self.rewardAdBlock(type,eAdRewardShowDismissScreen);
                    }
                        break;
                    default:
                        break;
                }
            }];
        }
            
        default:
            break;
    }
}

-(UIView*)getRectContainerView{
    return [[AWRectAdManager sharedInstance] getRectAdContainerView];
}

-(void)removeBanner{
    [[AWBannerAdManager sharedInstance] remove];
}


@end
