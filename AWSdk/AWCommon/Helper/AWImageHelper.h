//
//  ImageHelper.h
//  7minCardio
//
//  Created by lidong on 2019/5/16.
//  Copyright © 2019 maning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AWImageHelper : NSObject

+ (AWImageHelper*)sharedInstance;

+(UIImage*)getLaunchImage;

@end

