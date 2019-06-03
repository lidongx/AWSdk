//
//  AWDeviceHelper.m
//  TestAd
//
//  Created by lidong on 2019/5/22.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWDeviceHelper.h"
#import <UIKit/UIKit.h>


bool AWIsIphoneX(){
    bool isiPhoneX = false;
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        CGFloat height = [[UIScreen mainScreen] nativeBounds].size.height;
        CGFloat width = [[UIScreen mainScreen] nativeBounds].size.width;
        CGFloat ratio;
        if(height > width)
        {
            ratio = height/width;
        }
        else
        {
            ratio = width/height;
        }
        if(ratio >= 2.1 && ratio <2.3){
            isiPhoneX = true;
        }
    }
    return isiPhoneX;
}

bool AWIsIpadDevice()
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType containsString:@"iPad"]) {
        return YES;
    }
    return NO;
}

