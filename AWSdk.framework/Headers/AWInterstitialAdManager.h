//
//  AWInterstitialAdManager.h
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
//@import GoogleMobileAds;

typedef enum{
    eInterstitialAdNormalState,
    eInterstitialAdRequestingState,
    eInterstitialAdRequestSuccessState,
    eInterstitialAdRequestFailState,
    eInterstitialAdShowingSuccessState,
    eInterstitialAdShowingFailedState,
    eInterstitialAdCloseState,
    
}AWInterstitialAdState;

@protocol AWInterstitialAdManagerDelegate <NSObject>

@optional
-(void)interstitialLoadSuccess;
-(void)interstitialLoadFailedWithError;
-(void)interstitialWillPresentScreen;
-(void)interstitialDidFailToPresentScreen;
-(void)interstitialWillDismissScreen;
-(void)interstitialDidDismissScreen;
-(void)interstitialWillLeaveApplication;
@end

typedef enum{
    eInterstitialNormalState,
    
    eInterstitialAdLoadSuccessState,
    eInterstitialAdLoadFailedState,
    
    eInterstitialAdShowWillPresentScreen,
    eInterstitialAdShowDidFailToPresentScreen,
    eInterstitialAdWillDismissScreen,
    eInterstitialAdDidDismissScreen,
    eInterstitialAdClickWillLeaveApplication

}AWInterstitialBlockState;

typedef void (^AWInterstitialAdBlock)(AWInterstitialBlockState state);

@interface AWInterstitialAdManager : NSObject{
//    AWInterstitialAdBlock _requestAdBlock;
//    AWInterstitialAdBlock _showAdBlock;
}

@property(nonatomic,retain)AWInterstitialAdBlock requestAdBlock;
@property(nonatomic,retain)AWInterstitialAdBlock showAdBlock;

@property(nonatomic,strong)NSString* interstitialAdId;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic,weak,nullable)id<AWInterstitialAdManagerDelegate> delegate;
@property(nonatomic,assign)  AWInterstitialAdState currentState;



+(AWInterstitialAdManager*)sharedInstance;

-(BOOL)isReady;

-(void)show;

-(void)show:(UIViewController*)viewController;

-(void)preload;

-(void)preload:(AWInterstitialAdBlock)interstitialAdBlock;

-(void)showWithBlock:(AWInterstitialAdBlock)interstitialAdBlock;

-(void)showWithBlock:(AWInterstitialAdBlock)interstitialAdBlock andViewController:(UIViewController*)viewController;

@end

