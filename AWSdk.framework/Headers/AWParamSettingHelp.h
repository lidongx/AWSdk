//
//  ParamSettingHelp.h
//  7minCardio
//
//  Created by lidong on 2019/5/17.
//  Copyright © 2019 maning. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AWGetInt(key) [[AWParamSettingHelp sharedInstance] getIntValueByParam:key]
#define AWGetFloat(key) [[AWParamSettingHelp sharedInstance] getFloatValueByParam:key]
#define AWGetDouble(key) [[AWParamSettingHelp sharedInstance] getDoubleValueByParam:key]
#define AWGetString(key)  [[AWParamSettingHelp sharedInstance] getStringValueByParam:key]
#define AWGetBool(key)  [[AWParamSettingHelp sharedInstance] getBoolValueByParam:key]

#define AWSaveIntAsyn(key,value,bool) [[AWParamSettingHelp sharedInstance] setIntValue:value andParam:key andAsyn:true]
#define AWSaveFloatAsyn(key,value,bool) [[AWParamSettingHelp sharedInstance] setFloatValue:value andParam:key andAsyn:true]
#define AWSaveDoubleAsyn(key,value,bool) [[AWParamSettingHelp sharedInstance] setDoubleValue:value andParam:key andAsyn:true]
#define AWSaveStringAsyn(key,value,bool) [[AWParamSettingHelp sharedInstance] setStringValue:value andParam:key andAsyn:true]
#define AWSaveBoolAsyn(key,value,bool) [[AWParamSettingHelp sharedInstance] setBoolValue:value andParam:key andAsyn:true]

#define AWSaveInt(key,value) AWSaveIntAsyn(key,value,true)
#define AWSaveFloat(key,value) AWSaveFloatAsyn(key,value,true)
#define AWSaveDouble(key,value) AWSaveDoubleAsyn(key,value,true)
#define AWSaveString(key,value) AWSaveStringAsyn(key,value,true)
#define AWSaveBool(key,value) AWSaveBoolAsyn(key,value,true)


@interface AWParamSettingHelp : NSObject

+ (AWParamSettingHelp*)sharedInstance;

-(int)getIntValueByParam:(NSString*)param;
-(float)getFloatValueByParam:(NSString*)param;
-(double)getDoubleValueByParam:(NSString*)param;
-(NSString*)getStringValueByParam:(NSString*)param;
-(BOOL)getBoolValueByParam:(NSString*)param;

-(void)setIntValue:(int)intValue andParam:(NSString*)param andAsyn:(BOOL)b;
-(void)setFloatValue:(float)floatValue andParam:(NSString*)param andAsyn:(BOOL)b;
-(void)setDoubleValue:(double)doubleValue andParam:(NSString*)param andAsyn:(BOOL)b;
-(void)setStringValue:(NSString*)valueString andParam:(NSString*)param andAsyn:(BOOL)b;
-(void)setBoolValue:(BOOL)boolValue andParam:(NSString*)param andAsyn:(BOOL)b;
@end

