//
//  ParamSettingHelp.m
//  7minCardio
//
//  Created by lidong on 2019/5/17.
//  Copyright © 2019 maning. All rights reserved.
//

#import "AWParamSettingHelp.h"
#import "AWSingleMacro.h"

@implementation AWParamSettingHelp

AW_SINGLETON_IMPL(AWParamSettingHelp);


-(int)getIntValueByParam:(NSString*)param{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:param];
}
-(float)getFloatValueByParam:(NSString*)param{
    return [[NSUserDefaults standardUserDefaults] floatForKey:param];
}
-(double)getDoubleValueByParam:(NSString*)param{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:param];
}
-(NSString*)getStringValueByParam:(NSString*)param{
    return [[NSUserDefaults standardUserDefaults] stringForKey:param];
}
-(BOOL)getBoolValueByParam:(NSString*)param{
    return [[NSUserDefaults standardUserDefaults] boolForKey:param];
}
-(void)setIntValue:(int)intValue andParam:(NSString*)param andAsyn:(BOOL)b{
    [[NSUserDefaults standardUserDefaults] setInteger:intValue forKey:param];
    [self saveWithIsAysn:b];
}
-(void)setFloatValue:(float)floatValue andParam:(NSString*)param andAsyn:(BOOL)b{
    [[NSUserDefaults standardUserDefaults] setFloat:floatValue forKey:param];
    [self saveWithIsAysn:b];
}
-(void)setDoubleValue:(double)doubleValue andParam:(NSString*)param andAsyn:(BOOL)b{
    [[NSUserDefaults standardUserDefaults] setDouble:doubleValue forKey:param];
    [self saveWithIsAysn:b];
}
-(void)setStringValue:(NSString*)valueString andParam:(NSString*)param andAsyn:(BOOL)b{
    [[NSUserDefaults standardUserDefaults] setObject:valueString forKey:param];
    [self saveWithIsAysn:b];
}

-(void)setBoolValue:(BOOL)boolValue andParam:(NSString*)param andAsyn:(BOOL)b{
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:param];
    [self saveWithIsAysn:b];
}

-(void)saveWithIsAysn:(BOOL)b{
    if(b){
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [NSUserDefaults resetStandardUserDefaults];
    }
}


@end
