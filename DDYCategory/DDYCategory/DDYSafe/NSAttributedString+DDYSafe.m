#import "NSAttributedString+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation NSAttributedString (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class _NSConcreteAttributedString = NSClassFromString(@"NSConcreteAttributedString");
        // MARK: initWithString:
        [_NSConcreteAttributedString ddy_SwapMethod:@selector(initWithString:) swizzleSel:@selector(ddy_InitWithString:)];
        // MARK: initWithString:attributes:
        [_NSConcreteAttributedString ddy_SwapMethod:@selector(initWithString:attributes:) swizzleSel:@selector(ddy_InitWithString:attributes:)];
        // MARK: initWithAttributedString:
        [_NSConcreteAttributedString ddy_SwapMethod:@selector(initWithAttributedString:) swizzleSel:@selector(ddy_InitWithAttributedString:)];
    });
}

- (instancetype)ddy_InitWithString:(NSString *)str {
    id object = nil;
    @try {
        object = [self ddy_InitWithString:str];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return object;
    }
}

- (instancetype)ddy_InitWithString:(NSString *)str attributes:(NSDictionary<NSAttributedStringKey,id> *)attrs {
    id object = nil;
    @try {
        object = [self ddy_InitWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return object;
    }
}

- (instancetype)ddy_InitWithAttributedString:(NSAttributedString *)attrStr {
    id object = nil;
    @try {
        object = [self ddy_InitWithAttributedString:attrStr];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return object;
    }
}

@end
