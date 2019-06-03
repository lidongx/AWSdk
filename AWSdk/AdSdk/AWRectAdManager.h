//
//  AWRectAdManager.h
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import GoogleMobileAds;

typedef enum{
    eRectAdNormalState,
    eRectAdRequestingState,
    eRectAdRequestSuccessState,
    eRectAdRequestFailState,
}AWAdRectState;

@protocol AWRectAdManagerDelagte <NSObject>

@optional
-(void)rectAdLoadSuccess;
-(void)rectAdLoadFailedWithError:(nonnull GADRequestError *)error;
-(void)rectAdWillAppear;
-(void)rectAdWillDisAppear;
-(void)rectAdDidDisAppear;
-(void)rectAdClickLeaveApp;

@end

@interface AWRectAdManager : NSObject


@property(nonatomic,strong)NSString* rectAdId;
@property(nonatomic,weak,nullable)id<AWRectAdManagerDelagte> delegate;
@property(nonatomic, strong) GADBannerView *rectAdView;
@property(nonatomic,assign)  AWAdRectState currentState;
@property(nonatomic,assign) GADAdSize rectSize;
@property(nonatomic,assign)CGPoint center;

+(AWRectAdManager*)sharedInstance;

-(void)preload;

-(void)remove;

-(UIView*)getRectAdContainerView;

@end

