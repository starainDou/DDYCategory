#import "NSMutableDictionary+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation NSMutableDictionary (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class _NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
        // MARK: setObject:forKey:
        [_NSDictionaryM ddy_SwapMethod:@selector(setObject:forKey:) swizzleSel:@selector(ddy_SetObject:forKey:)];
        // MARK: setObject:forKeyedSubscript:
        [_NSDictionaryM ddy_SwapMethod:@selector(setObject:forKeyedSubscript:) swizzleSel:@selector(ddy_SetObject:forKeyedSubscript:)];
        // MARK: removeObjectForKey:
        [_NSDictionaryM ddy_SwapMethod:@selector(removeObjectForKey:) swizzleSel:@selector(ddy_RemoveObjectForKey:)];
    });
}

#pragma mark setObject:forKey:
- (void)ddy_SetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        [self ddy_SetObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark setObject:forKeyedSubscript:
- (void)ddy_SetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self ddy_SetObject:obj forKeyedSubscript:key];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark removeObjectForKey:
- (void)ddy_RemoveObjectForKey:(id)aKey {
    @try {
        [self ddy_RemoveObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

@end
