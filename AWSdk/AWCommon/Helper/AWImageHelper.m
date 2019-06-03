//
//  ImageHelper.m
//  7minCardio
//
//  Created by lidong on 2019/5/16.
//  Copyright © 2019 maning. All rights reserved.
//

#import "AWImageHelper.h"
#import "AWSingleMacro.h"
#import <UIKit/UIKit.h>
@implementation AWImageHelper

AW_SINGLETON_IMPL(AWImageHelper);

+(UIImage*)getLaunchImage{
    CGRect viewFrame = [UIScreen mainScreen].bounds;
    CGSize viewSize = viewFrame.size;
    // 仅做竖屏支持，先获取LaunchImage
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return  [UIImage imageNamed:launchImageName inBundle:nil compatibleWithTraitCollection:nil];
}


@end
