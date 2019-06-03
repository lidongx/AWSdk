//
//  ResourceHelp.h
//  yoga
//
//  Created by lidong on 2019/3/26.
//  Copyright © 2019 fitness.workouts.beginners. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWResourceHelp : NSObject

+(BOOL)checkBundleResource:(NSString*) fileName;
+(BOOL)copyFile:(NSString *)path topath:(NSString *)topath;
+(BOOL)deleteFile:(NSString*)path;

@end

