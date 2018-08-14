#import "NSObject+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation NSObject (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // !!!: setValue:forKey:
        [[self class] ddy_SwapMethod:@selector(setValue:forKey:) swizzleSel:@selector(ddy_SetValue:forKey:)];
        // !!!: setValue:forKeyPath:
        [[self class] ddy_SwapMethod:@selector(setValue:forKeyPath:) swizzleSel:@selector(ddy_SetValue:forKeyPath:)];
        // !!!: setValue:forUndefineKey:
        [[self class] ddy_SwapMethod:@selector(setValue:forUndefinedKey:) swizzleSel:@selector(ddy_SetValue:forUndefinedKey:)];
        // !!!: setValuesForKeysWithDictionary:
        [[self class] ddy_SwapMethod:@selector(setValuesForKeysWithDictionary:) swizzleSel:@selector(ddy_SetValuesForKeysWithDictionary:)];
        // !!!: methodSignatureForSelector:
        [[self class] ddy_SwapMethod:@selector(methodSignatureForSelector:) swizzleSel:@selector(ddy_MethodSignatureForSelector:)];
        // !!!: forwardInvocation:
        [[self class] ddy_SwapMethod:@selector(forwardInvocation:) swizzleSel:@selector(ddy_ForwardInvocation:)];
    });
}


#pragma mark - 交换的方法
#pragma mark setValue:forKey:
- (void)ddy_SetValue:(id)value forKey:(NSString *)key {
    @try {
        [self ddy_SetValue:value forKey:key];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark setValue:forKeyPath:
- (void)ddy_SetValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self ddy_SetValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark setValue:forUndefineKey:
- (void)ddy_SetValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self ddy_SetValue:value forUndefinedKey:key];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark setValuesForKeysWithDictionary:
- (void)ddy_SetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    @try {
        [self ddy_SetValuesForKeysWithDictionary:keyedValues];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

static NSString *_errorFunctionName;
void ddy_DynamicMethodIMP(id self, SEL _cmd) {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"errorClass"] = NSStringFromClass([self class]);
    userInfo[@"errorMethod"] = _errorFunctionName;
    NSString *reason = [NSString stringWithFormat:@"unrecognized selector sent to instance %p", _cmd];
    NSException *exception = [NSException exceptionWithName:@"DDYSafeForwardInvocation" reason:reason userInfo:userInfo];
    [self ddy_HandleException:exception defaultSolution:DDYSafeForward];
}

#pragma mark methodSignatureForSelector:
- (NSMethodSignature *)ddy_MethodSignatureForSelector:(SEL)aSelector {
    if (![self respondsToSelector:aSelector]) {
        _errorFunctionName = NSStringFromSelector(aSelector);
        class_addMethod([self class], aSelector, (IMP)ddy_DynamicMethodIMP, "v@:");
    }
    return [self ddy_MethodSignatureForSelector:aSelector];
}

#pragma mark forwardInvocation:
- (void)ddy_ForwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    if ([self respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:self];
    } else {
        [self ddy_ForwardInvocation:anInvocation];
    }
}

#pragma mark 发送通知
- (void)ddy_HandleException:(NSException *)exception defaultSolution:(NSString *)solution {
    // 堆栈信息
    NSArray *callStackSymbols = [NSThread callStackSymbols];

    NSMutableDictionary *notification = [NSMutableDictionary dictionary];
    if (exception) notification[DDYSafeException] = exception;
    if (callStackSymbols.count) notification[DDYSafeCrashStack] = callStackSymbols;
    if (solution) notification[DDYSafeSolution] = solution;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:DDYSafeNotification object:notification];
    });
}


#pragma mark 添加方法
+ (void)ddy_AddMethod:(SEL)methodSel methodImp:(SEL)methodImp {
    Method method = class_getInstanceMethod(self, methodImp);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(self, methodSel, methodIMP, types);
}

#pragma mark 交换实例方法
+ (void)ddy_SwapMethod:(SEL)originalSel swizzleSel:(SEL)swizzleSel {
    
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method swizzleMethod = class_getInstanceMethod(self, swizzleSel);
    if (class_addMethod(self, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
        class_replaceMethod(self, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

#pragma mark 交换类方法
+ (void)ddy_SwapClassMethod:(SEL)originalSel swizzleSel:(SEL)swizzleSel {
    
    Method originalMethod = class_getClassMethod(self, originalSel);
    Method swizzleMethod = class_getClassMethod(self, swizzleSel);
    if (class_addMethod(self, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
        class_replaceMethod(self, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

@end

// MARK: - http://www.cocoachina.com/ios/20160826/17422.html
