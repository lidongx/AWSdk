//
//  AWRewardAdManager.m
//  TestAd
//
//  Created by lidong on 2019/5/31.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWRewardAdManager.h"
#import "AWCommon.h"

#define KEY_REWARD @"Reward"
#define KEY_PHONE  @"Phone"
#define KEY_PAD    @"Pad"

#define APP_CONFIG_FILENAME @"AWAppConfig.plist"
#define RQUEST_TIME_DISTANCE 5   //banner广告请求时间间隔

@interface AWRewardAdManager()<GADRewardedAdDelegate>
{

}
@end

@implementation AWRewardAdManager

AW_SINGLETON_IMPL(AWRewardAdManager);

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self readRewardAdId];

    }
    return self;
}


-(void)readRewardAdId{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:APP_CONFIG_FILENAME ofType:nil]];
    
    if(dictionary){
        NSDictionary* rewardDict = [dictionary objectForKey:KEY_REWARD];
        if(rewardDict){
            if(AWIsIpadDevice()){
                NSArray* array = [rewardDict objectForKey:KEY_PAD];
                if(array && array.count>0){
                    NSString* rewardAdId = [array objectAtIndex:0];
                    self.rewardAdId = rewardAdId;
                }
            }
            else{
                NSArray* array = [rewardDict objectForKey:KEY_PHONE];
                if(array && array.count>0){
                    NSString* rewardAdId = [array objectAtIndex:0];
                    self.rewardAdId = rewardAdId;
                }
            }
        }
    }
}

-(void)preload{
    if(self.currentState==eRewardAdNormalState || self.currentState==eRewardAdRequestFailState){
        [self request];
    }
}

-(void)preload:(AWRewardAdBlock)rewardAdBlock{
    [self request:rewardAdBlock];
}

-(void)request{
    if(self.rewardAdId!=nil){
        [self requestAd:self.rewardAdId];
    }
}

-(void)request:(AWRewardAdBlock)rewardAdBlock{
    if(self.rewardAdId!=nil){
        [self requestAd:self.rewardAdId andBlock:rewardAdBlock];
    }
}


-(void)requestAd:(NSString*)unitId{
    
    self.rewardedAd = [[GADRewardedAd alloc]
                       initWithAdUnitID:unitId];
    
    
    self.currentState = eRewardAdRequestingState;
    
    GADRequest *request = [GADRequest request];
    [self.rewardedAd loadRequest:request completionHandler:^(GADRequestError * _Nullable error) {
        if (error) {
            // Handle ad failed to load case.
            self.currentState = eRewardAdRequestFailState;
            
            NSLog(@"reward error:%@",[error description]);
            
            if(self.delegate){
                if([self.delegate respondsToSelector:@selector(rewardAdLoadFailedWithError)]){
                    [self.delegate rewardAdLoadFailedWithError];
                }
            }
            
            
        } else {
            // Ad successfully loaded.
            self.currentState = eRewardAdRequestSuccessState;
            
            if(self.delegate){
                if([self.delegate respondsToSelector:@selector(rewardAdLoadSuccess)]){
                    [self.delegate rewardAdLoadSuccess];
                }
            }
        }
    }];

}

-(void)requestAd:(NSString*)unitId andBlock:(AWRewardAdBlock)rewardAdBlock{

    self.rewardRequestBlock = rewardAdBlock;
    
    self.rewardedAd = [[GADRewardedAd alloc]
                       initWithAdUnitID:unitId];
    
    
    self.currentState = eRewardAdRequestingState;
    
    GADRequest *request = [GADRequest request];
    [self.rewardedAd loadRequest:request completionHandler:^(GADRequestError * _Nullable error) {
        if (error) {
            // Handle ad failed to load case.
            self.currentState = eRewardAdRequestFailState;
            
            NSLog(@"reward error:%@",[error description]);
            
            if(self.delegate){
                if([self.delegate respondsToSelector:@selector(rewardAdLoadFailedWithError)]){
                    [self.delegate rewardAdLoadFailedWithError];
                }
            }
            
            if(self.rewardRequestBlock){
                self.rewardRequestBlock(eRewardAdLoadFailedState);
            }
            
            
        } else {
            // Ad successfully loaded.
            self.currentState = eRewardAdRequestSuccessState;
            
            if(self.delegate){
                if([self.delegate respondsToSelector:@selector(rewardAdLoadSuccess)]){
                    [self.delegate rewardAdLoadSuccess];
                }
            }
            
            if(self.rewardRequestBlock){
                self.rewardRequestBlock(eRewardAdLoadSuccessState);
            }
        }
    }];
    
}



-(BOOL)isReady{
    return self.rewardedAd && self.rewardedAd.isReady;
}

-(void)show{
    [self show:[self currentViewController]];
}

-(void)showWithBlock:(AWRewardAdBlock)rewardAdBlock{
    [self showWithBlock:rewardAdBlock AndViewController:[self currentViewController]];
}

-(void)show:(UIViewController*)viewController{
    if([self isReady]){
        [GADMobileAds sharedInstance].applicationVolume = 1.0f;
        [self.rewardedAd presentFromRootViewController:viewController delegate:self];
    }
}

-(void)showWithBlock:(AWRewardAdBlock)rewardAdBlock AndViewController:(UIViewController*)viewController{
    _rewardBlock = nil;
    if([self isReady]){
         self.rewardBlock = rewardAdBlock;
        [GADMobileAds sharedInstance].applicationVolume = 1.0f;
        [self.rewardedAd presentFromRootViewController:viewController delegate:self];
    }
    else{
        rewardAdBlock(eRewardAdShowFailedState);
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


/// Tells the delegate that the rewarded ad was presented.
- (void)rewardedAdDidPresent:(nonnull GADRewardedAd *)rewardedAd{
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(rewardAdDidPresentScreen)]){
            [self.delegate rewardAdDidPresentScreen];
        }
    }
    
    if(self.rewardBlock){
        self.rewardBlock(eRewardAdDidPresentScreenState);
    }
    
}

/// Tells the delegate that the rewarded ad was dismissed.
- (void)rewardedAdDidDismiss:(nonnull GADRewardedAd *)rewardedAd{
    
    [GADMobileAds sharedInstance].applicationVolume = 0.0f;
    
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(rewardAdDidDismissScreen)]){
            [self.delegate rewardAdDidDismissScreen];
        }
    }

    if(self.rewardBlock){
        self.rewardBlock(eRewardAdDidDismissScreenState);
    }
    
    self.currentState = eRewardAdNormalState;
    [self request];
}

/// Tells the delegate that the user earned a reward.
- (void)rewardedAd:(nonnull GADRewardedAd *)rewardedAd
 userDidEarnReward:(nonnull GADAdReward *)reward{
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(rewardedAdDidEarnReward)]){
            [self.delegate rewardedAdDidEarnReward];
        }
    }
    
    if(self.rewardBlock){
        self.rewardBlock(eRewardedAdDidEarnRewardState);
    }
    
}


@end
