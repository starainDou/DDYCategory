#import "DDYSafeHeader.h"

// 崩溃时发送通知
NSString *const DDYSafeNotification = @"DDYSafeNotification";
// 返回nil来防止崩溃
NSString *const DDYSafeReturnNil = @"DDYSafe return nil to avoid crash";
// 移除nil来防止崩溃
NSString *const DDYSafeRemoveNil = @"DDYSafe remove nil to avoid crash";
// 忽略操作来防止崩溃
NSString *const DDYSafeIgnore = @"DDYSafe ignore the operation to avoid crash";
// 消息转发来防止崩溃
NSString *const DDYSafeForward = @"DDYSafe forward invocation to avoid crash";
// 返回主线程防止崩溃
NSString *const DDYSafeMainThread = @"DDYSafe return main thread to avoid crash";
// 崩溃堆栈信息
NSString *const DDYSafeCrashStack = @"DDYSafeCrashStack";
// 异常信息
NSString *const DDYSafeException = @"DDYSafeException";
// 解决信息
NSString *const DDYSafeSolution = @"DDYSafeSolution";


@implementation DDYSafeHeader

+ (void)ddy_SafeEffective {
    // !!!:防止多次调用
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject ddy_SafeEffect];
    });
}

@end
