//
//  ResourceHelp.m
//  yoga
//
//  Created by lidong on 2019/3/26.
//  Copyright © 2019 fitness.workouts.beginners. All rights reserved.
//

#import "AWResourceHelp.h"
#import "AWSingleMacro.h"
@implementation AWResourceHelp

+(BOOL)checkBundleResource:(NSString*) fileName{
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        return true;
    }
    return false;
}

+(BOOL)copyFile:(NSString *)path topath:(NSString *)topath
{
    
    BOOL result = NO;
    NSError * error = nil;
    
    result = [[NSFileManager defaultManager] copyItemAtPath:path toPath:topath error:&error ];
    
    if (error){
        NSLog(@"copy失败：%@",[error localizedDescription]);
    }
    return result;
}

+(BOOL)deleteFile:(NSString*)path
{
    //文件不存在
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        return YES;
    }
    
    BOOL result = NO;
    NSError * error = nil;
    
    result = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    
    if (error){
        NSLog(@"delete失败：%@",[error localizedDescription]);
    }
    
    return result;
}


@end
