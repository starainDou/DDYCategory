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
// 崩溃堆栈信息
extern NSString *const DDYSafeCrashStack;
// 异常信息
extern NSString *const DDYSafeException;
// 解决信息
extern NSString *const DDYSafeSolution;

@interface DDYSafeHeader : NSObject

+ (void)ddy_SafeEffective;

@end
