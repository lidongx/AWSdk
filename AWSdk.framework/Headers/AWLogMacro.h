//
//  LogMacro.h
//  7minCardio
//
//  Created by lidong on 2019/5/8.
//  Copyright © 2019 maning. All rights reserved.
//

#ifndef LogMacro_h
#define LogMacro_h

// 自定义日志输出方法
#ifdef DEBUG

#define AW_LOG(s, ...) do { \
NSLog(@"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__]);\
} while(0)

#else

#define AW_LOG(s, ...) do {} while(0)

#endif

#endif /* LogMacro_h */
