//
//  SingleMacro.h
//  7minCardio
//
//  Created by lidong on 2019/5/8.
//  Copyright © 2019 maning. All rights reserved.
//

#ifndef SingleMacro_h
#define SingleMacro_h

// 单例实现
#define AW_SINGLETON_IMPL(__CLASS_NAME) \
\
static __CLASS_NAME* instance = nil;\
\
+ (__CLASS_NAME*)sharedInstance \
{ \
@synchronized(self) { \
if ( nil == instance ) { \
instance = [[__CLASS_NAME alloc] init]; \
} \
} \
\
return instance; \
} \
\



#endif /* SingleMacro_h */
