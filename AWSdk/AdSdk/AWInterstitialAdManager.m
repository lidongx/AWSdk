//
//  AWInterstitialAdManager.m
//  TestAd
//
//  Created by lidong on 2019/5/23.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWInterstitialAdManager.h"
#import "AWCommon.h"

#define KEY_INTERSTITIAL @"Interstitial"
#define KEY_PHONE  @"Phone"
#define KEY_PAD    @"Pad"

#define APP_CONFIG_FILENAME @"AWAppConfig.plist"
#define RQUEST_TIME_DISTANCE 5   //banner广告请求时间间隔

@interface AWInterstitialAdManager()<GADInterstitialDelegate>
{
   
}
@end



@implementation AWInterstitialAdManager

AW_SINGLETON_IMPL(AWInterstitialAdManager);

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self readInterstitialAdId];
        
    }
    return self;
}

-(void)readInterstitialAdId{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:APP_CONFIG_FILENAME ofType:nil]];
    
    if(dictionary){
        NSDictionary* interstitialDict = [dictionary objectForKey:KEY_INTERSTITIAL];
        if(interstitialDict){
            if(AWIsIpadDevice()){
                NSArray* array = [interstitialDict objectForKey:KEY_PAD];
                if(array && array.count>0){
                    NSString* interstitialAdId = [array objectAtIndex:0];
                    self.interstitialAdId = interstitialAdId;
                }
            }
            else{
                NSArray* array = [interstitialDict objectForKey:KEY_PHONE];
                if(array && array.count>0){
                    NSString* interstitialAdId = [array objectAtIndex:0];
                    self.interstitialAdId = interstitialAdId;
                }
            }
        }
    }
}

-(void)preload{
    [self request];
}

-(void)preload:(AWInterstitialAdBlock)interstitialAdBlock{
    [self request:interstitialAdBlock];
}

-(void)request{
    if(self.interstitialAdId!=nil){
        if(self.currentState == eInterstitialAdNormalState || self.currentState == eInterstitialAdRequestFailState){
                [self requestAd:self.interstitialAdId];
        }
    
    }
}

-(void)request:(AWInterstitialAdBlock)interstitialAdBlock{
    if(self.interstitialAdId!=nil){
        if(self.currentState == eInterstitialAdNormalState || self.currentState == eInterstitialAdRequestFailState){
            self.requestAdBlock = interstitialAdBlock;
            [self requestAd:self.interstitialAdId];
        }
    }
}



-(void)requestAd:(NSString*)unitId{
    self.currentState = eInterstitialAdRequestingState;
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:unitId];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    self.interstitial = interstitial;
}


-(void)show{
    [self show:[self currentViewController]];
}

-(void)show:(UIViewController*)viewController{
    if(self.interstitial && self.interstitial.isReady){
         [GADMobileAds sharedInstance].applicationVolume = 1.0f;
        [self.interstitial presentFromRootViewController:viewController];
    }
}

-(void)showWithBlock:(AWInterstitialAdBlock)interstitialAdBlock{
    [self showWithBlock:interstitialAdBlock andViewController:[self currentViewController]];
}

-(void)showWithBlock:(AWInterstitialAdBlock)interstitialAdBlock andViewController:(UIViewController*)viewController{
    if(self.interstitial && self.interstitial.isReady){
        self.showAdBlock = interstitialAdBlock;
        [GADMobileAds sharedInstance].applicationVolume = 1.0f;
        [self.interstitial presentFromRootViewController:viewController];
    }
    else{
        interstitialAdBlock(eInterstitialAdShowDidFailToPresentScreen);
    }
}



- (UIViewController *)currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}


-(BOOL)isReady{
    return self.interstitial && self.interstitial.isReady;
}



/// Called when an interstitial ad request succeeded. Show it at the next transition point in your
/// application such as when transitioning between view controllers.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
        AW_LOG(@"interstitialDidReceiveAd");
    self.currentState = eInterstitialAdRequestSuccessState;
    
    NSLog(@"%d",ad.isReady);
    
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(interstitialLoadSuccess)]){
            [self.delegate interstitialLoadSuccess];
        }
    }
    
    if(self.requestAdBlock){
        self.requestAdBlock(eInterstitialAdLoadSuccessState);
    }
    
}

/// Called when an interstitial ad request completed without an interstitial to
/// show. This is common since interstitials are shown sparingly to users.
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    AW_LOG(@"didFailToReceiveAdWithError:%@",[error description]);
    
     self.currentState = eInterstitialAdRequestFailState;
    
    NSLog(@"interstitialAd Error:%@",[error description]);
    
     if(self.delegate){
        if([self.delegate respondsToSelector:@selector(interstitialLoadFailedWithError)]){
            [self.delegate interstitialLoadFailedWithError];
        }
    }
    
    if(self.requestAdBlock){
        self.requestAdBlock(eInterstitialAdLoadFailedState);
    }
    
    
//    [self performSelector:@selector(request) withObject:nil afterDelay:RQUEST_TIME_DISTANCE];
    
}

#pragma mark Display-Time Lifecycle Notifications

/// Called just before presenting an interstitial. After this method finishes the interstitial will
/// animate onto the screen. Use this opportunity to stop animations and save the state of your
/// application in case the user leaves while the interstitial is on screen (e.g. to visit the App
/// Store from a link on the interstitial).
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
     AW_LOG(@"interstitialWillPresentScreen");
    
    self.currentState = eInterstitialAdShowingSuccessState;
    
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(interstitialWillPresentScreen)]){
            [self.delegate interstitialWillPresentScreen];
        }
    }
    
    if(self.showAdBlock){
        self.showAdBlock(eInterstitialAdShowWillPresentScreen);
    }
    
    
}

/// Called when |ad| fails to present.
- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad{
       AW_LOG(@"interstitialDidFailToPresentScreen");
    
    self.currentState = eInterstitialAdShowingFailedState;
    
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(interstitialDidFailToPresentScreen)]){
            [self.delegate interstitialDidFailToPresentScreen];
        }
    }
    
    if(self.showAdBlock){
        self.showAdBlock(eInterstitialAdShowDidFailToPresentScreen);
    }
    
     [GADMobileAds sharedInstance].applicationVolume = 0.0f;
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad
{
    AW_LOG(@"interstitialWillDismissScreen");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(interstitialWillDismissScreen)]){
            [self.delegate interstitialWillDismissScreen];
        }
    }
    
    if(self.showAdBlock){
        self.showAdBlock(eInterstitialAdWillDismissScreen);
    }
    
}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    
    self.currentState = eInterstitialAdCloseState;
    
     AW_LOG(@"interstitialDidDismissScreen");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(interstitialDidDismissScreen)]){
            [self.delegate interstitialDidDismissScreen];
        }
    }
    
    if(self.showAdBlock){
        self.showAdBlock(eInterstitialAdDidDismissScreen);
    }
    
    [GADMobileAds sharedInstance].applicationVolume = 0.0f;
    
    self.currentState = eInterstitialAdNormalState;
    
    [self request];
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store). The normal
/// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
/// before this.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
     AW_LOG(@"interstitialWillLeaveApplication");
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(interstitialWillLeaveApplication)]){
            [self.delegate interstitialWillLeaveApplication];
        }
    }
    if(self.showAdBlock){
        self.showAdBlock(eInterstitialAdClickWillLeaveApplication);
    }
}



@end
