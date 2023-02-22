//
//  AppMacro.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#ifndef AppMacro_h
#define AppMacro_h

#define Local(value) [JadeLocalizationManager getStringByKey:value]

#define kWEAKSELF __weak typeof(self) weakSelf = self
#define kSTRONGSELF __strong typeof(self) strongSelf = weakSelf

#ifdef DEBUG
#define NSLog(FORMAT, ...) printf("%s : %d >>>>>>>>>>>> %s \n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif

#endif /* AppMacro_h */
