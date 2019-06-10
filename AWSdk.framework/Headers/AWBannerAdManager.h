//
//  BannerManager.h
//  TestAd
//
//  Created by lidong on 2019/5/22.
//  Copyright © 2019 lidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

typedef enum{
    eBannerAdNormalState,
    eBannerAdRequestingState,
    eBannerAdRequestSuccessState,
    eBannerAdRequestFailState,
}AWAdBannerState;

@protocol AWBannerAdManagerDelagte <NSObject>

@optional
-(void)bannerLoadSuccess;
-(void)bannerLoadFailedWithError:(nonnull GADRequestError *)error;
-(void)bannerWillAppear;
-(void)bannerWillDisAppear;
-(void)bannerDidDisAppear;
-(void)bannerClickLeaveApp;

@end

@interface AWBannerAdManager : NSObject

@property(nonatomic,strong)NSString* bannerId;
@property(nonatomic,weak,nullable)id<AWBannerAdManagerDelagte> delegate;
@property(nonatomic, strong) GADBannerView *bannerView;
@property(nonatomic,assign) AWAdBannerState currentState;
@property(nonatomic,assign) GADAdSize bannerSize;

@property(nonatomic,assign)CGPoint center;

+(AWBannerAdManager*)sharedInstance;

-(void)preload;

-(void)show;

-(void)show:(UIView*)parentView;

-(void)remove;

-(void)requestAd:(NSString*)unitId;


@end

