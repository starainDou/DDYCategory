#import "DDYSafeHeader.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

// !!!: 崩溃预防
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


// !!!: 崩溃发生
NSString * const DDYExceptionName = @"DDYExceptionName";
NSString * const DDYSignalKey = @"DDYSignalKey";
NSString * const DDYAddressesKey = @"DDYAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 100;


@implementation DDYSafeHeader

#pragma mark - 安全守护，旨在预防
+ (void)ddy_SafeEffective {
    // !!!:防止多次调用
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject ddy_SafeEffect];
        [NSArray ddy_SafeEffect];
        [NSMutableArray ddy_SafeEffect];
        [NSDictionary ddy_SafeEffect];
        [NSMutableDictionary ddy_SafeEffect];
        [NSString ddy_SafeEffect];
        [NSMutableString ddy_SafeEffect];
        [NSAttributedString ddy_SafeEffect];
        [NSMutableAttributedString ddy_SafeEffect];
        [NSNull ddy_SafeEffect];
        [UIView ddy_SafeEffect];
        [UITableView ddy_SafeEffect];
    });
}

#pragma mark - 崩溃发生，防止闪退
+ (void)ddy_HandleUncaughtException {
    NSLog(@"请在断开数据线连接(当然也不允许无线调试)状态测试");
    NSSetUncaughtExceptionHandler(&HandleException);
    signal(SIGABRT, SignalHandler);
    signal(SIGILL,  SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGFPE,  SignalHandler);
    signal(SIGBUS,  SignalHandler);
    signal(SIGPIPE, SignalHandler);
}

#pragma mark 处理异常
void HandleException(NSException *exception) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    // 如果太多不用处理
    if (exceptionCount > UncaughtExceptionMaximum) {
        return;
    }
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    while (1) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
}

#pragma mark 处理signal报错
void SignalHandler(int signal) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    
    if (exceptionCount > UncaughtExceptionMaximum) {
        return;
    }
    
    NSString* description = nil;
    switch (signal) {
        case SIGABRT:
            description = [NSString stringWithFormat:@"Signal SIGABRT was raised!\n"];
            break;
        case SIGILL:
            description = [NSString stringWithFormat:@"Signal SIGILL was raised!\n"];
            break;
        case SIGSEGV:
            description = [NSString stringWithFormat:@"Signal SIGSEGV was raised!\n"];
            break;
        case SIGFPE:
            description = [NSString stringWithFormat:@"Signal SIGFPE was raised!\n"];
            break;
        case SIGBUS:
            description = [NSString stringWithFormat:@"Signal SIGBUS was raised!\n"];
            break;
        case SIGPIPE:
            description = [NSString stringWithFormat:@"Signal SIGPIPE was raised!\n"];
            break;
        default:
            description = [NSString stringWithFormat:@"Signal %d was raised!",signal];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:getAddressKey() forKey:DDYAddressesKey];
    [userInfo setObject:[NSNumber numberWithInt:signal] forKey:DDYSignalKey];
    
    HandleException([NSException exceptionWithName:DDYExceptionName reason:description userInfo:userInfo]);
}

NSArray *getAddressKey() {
    // 指针列表
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}

@end
