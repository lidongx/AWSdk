//
//  AWRectAdManager.m
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWRectAdManager.h"
#import "AWCommon.h"

#define KEY_RECT @"Rect"
#define KEY_PHONE  @"Phone"
#define KEY_PAD    @"Pad"

#define APP_CONFIG_FILENAME @"AWAppConfig.plist"
#define RQUEST_TIME_DISTANCE 15   //banner广告请求时间间隔

@interface AWRectAdManager()<GADBannerViewDelegate>

@property(nonatomic,strong)UIView* containerView;


@end

@implementation AWRectAdManager

AW_SINGLETON_IMPL(AWRectAdManager);

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        GADAdSize size = kGADAdSizeMediumRectangle;

        self.rectAdView = [[GADBannerView alloc] initWithAdSize:size];
        self.rectAdView.rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        self.rectAdView.delegate = self;
        
        self.containerView = [[UIView alloc] initWithFrame:self.rectAdView.bounds];
        [self.containerView addSubview:self.rectAdView];
        
        _center = CGPointMake(AWFullScreenWidth()/2, AWFullScreenHeight()/2);
        
        [self readRectAdId];
        
    }
    return self;
}

-(void)setRectSize:(GADAdSize)rectSize{
    
    _rectSize =rectSize;
    
    if(self.containerView && self.containerView.superview!=nil){
        [self.containerView removeFromSuperview];
    }
    
    self.rectAdView = [[GADBannerView alloc] initWithAdSize:_rectSize];
    self.rectAdView.rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    self.rectAdView.delegate = self;
    
    self.containerView = [[UIView alloc] initWithFrame:self.rectAdView.bounds];
    [self.containerView addSubview:self.rectAdView];
    
    _center = CGPointMake(AWFullScreenWidth()/2, AWFullScreenHeight()/2);
}

-(void)readRectAdId{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:APP_CONFIG_FILENAME ofType:nil]];
    
    if(dictionary){
        NSDictionary* rectDict = [dictionary objectForKey:KEY_RECT];
        if(rectDict){
            if(AWIsIpadDevice()){
                NSArray* array = [rectDict objectForKey:KEY_PAD];
                if(array && array.count>0){
                    NSString* rectAdId = [array objectAtIndex:0];
                    self.rectAdId = rectAdId;
                }
            }
            else{
                NSArray* array = [rectDict objectForKey:KEY_PHONE];
                if(array && array.count>0){
                    NSString* rectAdId = [array objectAtIndex:0];
                    self.rectAdId = rectAdId;
                }
            }
        }
    }
}

-(void)preload{
    [self request];
}

-(void)remove{
    if(self.containerView.superview!=nil){
        [self.containerView removeFromSuperview];
    }
}

-(void)request{
    if(self.rectAdId!=nil){
        [self requestAd:self.rectAdId];
    }
}

-(void)requestAd:(NSString*)unitId{
    self.rectAdView.adUnitID = unitId;
    self.currentState = eRectAdRequestingState;
    [self.rectAdView loadRequest:[GADRequest request]];
}

-(UIView*)getRectAdContainerView{
    self.containerView.center = self.center;
    return self.containerView;
}

-(void)setCenter:(CGPoint)center{
    _center = center;
    if(self.containerView.superview){
        self.containerView.center = _center;
    }
}

/// Tells the delegate that an ad request successfully received an ad. The delegate may want to add
/// the banner view to the view hierarchy if it hasn't been added yet.
- (void)adViewDidReceiveAd:(nonnull GADBannerView *)bannerView{
    AW_LOG(@"adViewDidReceiveAd");
    self.currentState = eRectAdRequestSuccessState;
    
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(rectAdLoadSuccess)]){
            [self.delegate rectAdLoadSuccess];
        }
    }
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(nonnull GADBannerView *)bannerView
didFailToReceiveAdWithError:(nonnull GADRequestError *)error{
    AW_LOG(@"didFailToReceiveAdWithError");
    self.currentState = eRectAdRequestFailState;
    
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(rectAdLoadFailedWithError:)]){
            [self.delegate rectAdLoadFailedWithError:error];
        }
    }
    
//    [self performSelector:@selector(request) withObject:nil afterDelay:RQUEST_TIME_DISTANCE];
}

#pragma mark Click-Time Lifecycle Notifications

/// Tells the delegate that a full screen view will be presented in response to the user clicking on
/// an ad. The delegate may want to pause animations and time sensitive interactions.
- (void)adViewWillPresentScreen:(nonnull GADBannerView *)bannerView{
    AW_LOG(@"bannerWillAppear");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(rectAdWillAppear)]){
              [self.delegate rectAdWillAppear];
        }
    }
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(nonnull GADBannerView *)bannerView{
    AW_LOG(@"bannerWillDisAppear");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(rectAdWillDisAppear)]){
            [self.delegate rectAdWillDisAppear];
        }
    }
}

/// Tells the delegate that the full screen view has been dismissed. The delegate should restart
/// anything paused while handling adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(nonnull GADBannerView *)bannerView{
    AW_LOG(@"bannerDidDisAppear");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(rectAdDidDisAppear)]){
            [self.delegate rectAdDidDisAppear];
        }
   
    }
}

/// Tells the delegate that the user click will open another app, backgrounding the current
/// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
/// are called immediately before this method is called.
- (void)adViewWillLeaveApplication:(nonnull GADBannerView *)bannerView{
    AW_LOG(@"bannerClickLeaveApp");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(rectAdClickLeaveApp)]){
                 [self.delegate rectAdClickLeaveApp];
        }
   
    }
}




@end
