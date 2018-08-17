#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "NSObject+DDYSafe.h"
#import "NSNull+DDYSafe.h"

#import "NSArray+DDYSafe.h"
#import "NSMutableArray+DDYSafe.h"

#import "NSDictionary+DDYSafe.h"
#import "NSMutableDictionary+DDYSafe.h"

#import "NSString+DDYSafe.h"
#import "NSMutableString+DDYSafe.h"

#import "NSAttributedString+DDYSafe.h"
#import "NSMutableAttributedString+DDYSafe.h"

#import "UIView+DDYSafe.h"
#import "UITableView+DDYSafe.h"

// 崩溃时发送通知
extern NSString *const DDYSafeNotification;
// 返回nil来防止崩溃
extern NSString *const DDYSafeReturnNil;
// 移除nil来防止崩溃
extern NSString *const DDYSafeRemoveNil;
// 忽略操作来防止崩溃
extern NSString *const DDYSafeIgnore;
// 消息转发来防止崩溃
extern NSString *const DDYSafeForward;
// 返回主线程防止崩溃
extern NSString *const DDYSafeMainThread;
// 崩溃堆栈信息
extern NSString *const DDYSafeCrashStack;
// 异常信息
extern NSString *const DDYSafeException;
// 解决信息
extern NSString *const DDYSafeSolution;

@interface DDYSafeHeader : NSObject

/** 安全守护，旨在预防 */
+ (void)ddy_SafeEffective;

/** 崩溃发生，防止闪退 */
+ (void)ddy_HandleUncaughtException;

@end

/**
 !!!:由于不崩溃了,反而影响力三方搜集崩溃信息
 TODO:利用自定义方式搜集，如bugly的 [BuglyManager reportErrorName:Bugly_ErrorName_AvoidCrash errorReason:errorReason callStack:callStack extraInfo:nil];
 */
