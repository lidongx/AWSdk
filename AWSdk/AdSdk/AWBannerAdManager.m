//
//  BannerManager.m
//  TestAd
//
//  Created by lidong on 2019/5/22.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWBannerAdManager.h"
#import "AWCommon.h"


#define KEY_BANNER @"Banner"
#define KEY_PHONE  @"Phone"
#define KEY_PAD    @"Pad"

#define APP_CONFIG_FILENAME @"AWAppConfig.plist"

#define RQUEST_TIME_DISTANCE 15   //banner广告请求时间间隔

@interface AWBannerAdManager()<GADBannerViewDelegate>

@property(nonatomic,strong)UIView* containerView;


@end

@implementation AWBannerAdManager

AW_SINGLETON_IMPL(AWBannerAdManager);

- (instancetype)init
{
    self = [super init];
    if (self) {

        GADAdSize size;
        if(AWIsIpadDevice()){
            size = kGADAdSizeLeaderboard;
        }
        else {
            size = kGADAdSizeBanner;
        }
    
        self.bannerView = [[GADBannerView alloc] initWithAdSize:size];
        self.bannerView.rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        self.bannerView.delegate = self;
    
        self.containerView = [[UIView alloc] initWithFrame:self.bannerView.bounds];
        [self.containerView addSubview:self.bannerView];
        
        _center = CGPointMake(AWFullScreenWidth()/2, AWFullScreenHeight()-self.containerView.bounds.size.height/2);
        
        if (@available(iOS 11, *)) {
            UIWindow* window = [[UIApplication sharedApplication].windows objectAtIndex:0];
            UIEdgeInsets inset  =  window.safeAreaInsets;
            float bottomOffset = inset.bottom;
            _center=CGPointMake(_center.x, _center.y-bottomOffset);
        }
        [self readBannerId];
        
    }
    return self;
}

-(void)setBannerSize:(GADAdSize)bannerSize{
    if(self.containerView && self.containerView.superview!=nil){
        [self.containerView removeFromSuperview];
    }
    _bannerSize = bannerSize;
    self.bannerView = [[GADBannerView alloc] initWithAdSize:_bannerSize];
    self.bannerView.rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    self.bannerView.delegate = self;
    
    self.containerView = [[UIView alloc] initWithFrame:self.bannerView.bounds];
    [self.containerView addSubview:self.bannerView];
    
    _center = CGPointMake(AWFullScreenWidth()/2, AWFullScreenHeight()-self.containerView.bounds.size.height/2);
    
    if (@available(iOS 11, *)) {
        UIWindow* window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        UIEdgeInsets inset  =  window.safeAreaInsets;
        float bottomOffset = inset.bottom;
        _center=CGPointMake(_center.x, _center.y-bottomOffset);
    }
    
}

-(void)readBannerId{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:APP_CONFIG_FILENAME ofType:nil]];
    
    if(dictionary){
        NSDictionary* bannerDict = [dictionary objectForKey:KEY_BANNER];
        if(bannerDict){
            if(AWIsIpadDevice()){
                NSArray* array = [bannerDict objectForKey:KEY_PAD];
                if(array && array.count>0){
                    NSString* bannerId = [array objectAtIndex:0];
                    self.bannerId = bannerId;
                }
            }
            else{
                NSArray* array = [bannerDict objectForKey:KEY_PHONE];
                if(array && array.count>0){
                    NSString* bannerId = [array objectAtIndex:0];
                    self.bannerId = bannerId;
                }
            }
        }
    }
}


-(void)preload{
    [self request];
}

-(void)request{
    if(self.bannerId!=nil){
        [self requestAd:self.bannerId];
    }
}

-(void)requestAd:(NSString*)unitId{
    self.bannerView.adUnitID = unitId;
    self.currentState = eBannerAdRequestingState;
    [self.bannerView loadRequest:[GADRequest request]];
}

-(void)show:(UIView*)parentView{
    
    [self remove];
    
    if(parentView !=nil){
        [parentView addSubview:self.containerView];
    }
    else{
        UIWindow* window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        window.backgroundColor = [UIColor yellowColor];
        [window addSubview:self.containerView];
        self.containerView.center = self.center;
    }
}

-(void)show{
    [self show:nil];
}

-(void)remove{
    if(self.containerView.superview!=nil){
        [self.containerView removeFromSuperview];
    }
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
    self.currentState = eBannerAdRequestSuccessState;
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(bannerLoadSuccess)]){
            [self.delegate bannerLoadSuccess];
        }
    }
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(nonnull GADBannerView *)bannerView
didFailToReceiveAdWithError:(nonnull GADRequestError *)error{
     AW_LOG(@"didFailToReceiveAdWithError");
    self.currentState = eBannerAdRequestFailState;
    
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(bannerLoadFailedWithError:)]){
            [self.delegate bannerLoadFailedWithError:error];
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
        if([self.delegate respondsToSelector:@selector(bannerWillAppear)]){
              [self.delegate bannerWillAppear];
        }
      
    }
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(nonnull GADBannerView *)bannerView{
      AW_LOG(@"bannerWillDisAppear");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(bannerWillDisAppear)]){
                 [self.delegate bannerWillDisAppear];
        }
   
    }
}

/// Tells the delegate that the full screen view has been dismissed. The delegate should restart
/// anything paused while handling adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(nonnull GADBannerView *)bannerView{
     AW_LOG(@"bannerDidDisAppear");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(bannerDidDisAppear)]){
            [self.delegate bannerDidDisAppear];
        }
    }
}

/// Tells the delegate that the user click will open another app, backgrounding the current
/// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
/// are called immediately before this method is called.
- (void)adViewWillLeaveApplication:(nonnull GADBannerView *)bannerView{
     AW_LOG(@"bannerClickLeaveApp");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(bannerClickLeaveApp)]){
            [self.delegate bannerClickLeaveApp];
        }
    }
}



@end
