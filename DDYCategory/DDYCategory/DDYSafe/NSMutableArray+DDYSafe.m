#import "NSMutableArray+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation NSMutableArray (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class _NSArrayM = NSClassFromString(@"__NSArrayM");
        // MARK: objectAtIndex:
        [_NSArrayM ddy_SwapMethod:@selector(objectAtIndex:) swizzleSel:@selector(ddy_ObjectAtIndex:)];
        // MARK: addObject:
        [_NSArrayM ddy_SwapMethod:@selector(addObject:) swizzleSel:@selector(ddy_AddObject:)];
        // MARK: objectAtIndexedSubscript:
        [_NSArrayM ddy_SwapMethod:@selector(objectAtIndexedSubscript:) swizzleSel:@selector(ddy_ObjectAtIndexedSubscript:)];
        // MARK: setObject:atIndexedSubscript:
        [_NSArrayM ddy_SwapMethod:@selector(setObject:atIndexedSubscript:) swizzleSel:@selector(ddy_SetObject:atIndexedSubscript:)];
        // MARK: removeObjectAtIndex:
        [_NSArrayM ddy_SwapMethod:@selector(removeObjectAtIndex:) swizzleSel:@selector(ddy_RemoveObjectAtIndex:)];
        // MARK: removeObjectsInRange:
        [_NSArrayM ddy_SwapMethod:@selector(removeObjectsInRange:) swizzleSel:@selector(ddy_RemoveObjectsInRange:)];
        // MARK: insertObject:atIndex:
        [_NSArrayM ddy_SwapMethod:@selector(insertObject:atIndex:) swizzleSel:@selector(ddy_InsertObject:atIndex:)];
        // MARK: getObjects:range:
        [_NSArrayM ddy_SwapMethod:@selector(getObjects:range:) swizzleSel:@selector(ddy_GetObjects:range:)];
        // MARK: replaceObjectAtIndex:withObject:
        [_NSArrayM ddy_SwapMethod:@selector(replaceObjectAtIndex:withObject:) swizzleSel:@selector(ddy_ReplaceObjectAtIndex:withObject:)];
    });
}

#pragma mark objectAtIndex:
- (id)ddy_ObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self ddy_ObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return object;
    }
}

#pragma mark addObject:
- (void)ddy_AddObject:(id)anObject {
    @try {
        [self ddy_AddObject:anObject];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark objectAtIndexedSubscript:
- (id)ddy_ObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    @try {
        object = [self ddy_ObjectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return object;
    }
}

#pragma mark setObject:atIndexedSubscript:
- (void)ddy_SetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self ddy_SetObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark removeObjectAtIndex:
- (void)ddy_RemoveObjectAtIndex:(NSUInteger)index {
    @try {
        [self ddy_RemoveObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark removeObjectsInRange:
- (void)ddy_RemoveObjectsInRange:(NSRange)range {
    @try {
        [self ddy_RemoveObjectsInRange:range];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark insertObject:atIndex:
- (void)ddy_InsertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self ddy_InsertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark getObjects:range:
- (void)ddy_GetObjects:(__unsafe_unretained id  _Nonnull [])objects range:(NSRange)range {
    @try {
        [self ddy_GetObjects:objects range:range];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

#pragma mark replaceObjectAtIndex:withObject:
- (void)ddy_ReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    @try {
        [self ddy_ReplaceObjectAtIndex:index withObject:anObject];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

@end

/**
 ???: 什么时候出现不同类型？
 见 NSArray+DDYSafe.m
 */
