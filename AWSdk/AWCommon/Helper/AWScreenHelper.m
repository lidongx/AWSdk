//
//  ScreenHelper.m
//  TestAd
//
//  Created by lidong on 2019/5/22.
//  Copyright © 2019 lidong. All rights reserved.
//

#import "AWScreenHelper.h"

/**
 * 返回全屏大小
 */
CGRect AWFullScreenBounds()
{
    return [[UIScreen mainScreen] bounds];
}

/**
 * 全屏宽
 */
CGFloat AWFullScreenWidth()
{
    return CGRectGetWidth(AWFullScreenBounds());
}

/**
 * 全屏高
 */
CGFloat AWFullScreenHeight()
{
    return CGRectGetHeight(AWFullScreenBounds());
}
