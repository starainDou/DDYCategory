#import "NSMutableAttributedString+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation NSMutableAttributedString (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class _NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
        [_NSConcreteMutableAttributedString ddy_SwapMethod:@selector(initWithString:)
                                                swizzleSel:@selector(ddy_InitWithString:)];
        [_NSConcreteMutableAttributedString ddy_SwapMethod:@selector(initWithString:attributes:)
                                                swizzleSel:@selector(ddy_InitWithString:attributes:)];
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

@end
