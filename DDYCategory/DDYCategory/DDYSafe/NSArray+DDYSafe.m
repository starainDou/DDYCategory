#import "NSArray+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation NSArray (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // !!!: - 交换类方法 http://blog.sina.com.cn/s/blog_6558840b0101dkhq.html
        [[self class] ddy_SwapClassMethod:@selector(arrayWithObjects:count:)
                               swizzleSel:@selector(ddy_ArrayWithObjects:count:)];
        // !!!: - 交换实例方法
        Class _NSArray = NSClassFromString(@"NSArray");
        Class _NSArray0 = NSClassFromString(@"__NSArray0");
        Class _NSArrayI = NSClassFromString(@"__NSArrayI");
        Class _NSArraySingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        // MARK: objectsAtIndexes:
        [_NSArray ddy_SwapMethod:@selector(objectsAtIndexes:) swizzleSel:@selector(ddy_ObjectsAtIndexes:)];
        // MARK: objectAtIndex:
        [_NSArray0 ddy_SwapMethod:@selector(objectAtIndex:) swizzleSel:@selector(ddy_NSArray0ObjectAtIndex:)];
        [_NSArrayI ddy_SwapMethod:@selector(objectAtIndex:) swizzleSel:@selector(ddy_NSArrayIObjectAtIndex:)];
        [_NSArraySingleObjectArrayI ddy_SwapMethod:@selector(objectAtIndex:) swizzleSel:@selector(ddy_NSArraySingleObjectAtIndex:)];
        // MARK: objectAtIndexedSubscript:
        [_NSArrayI ddy_SwapMethod:@selector(objectAtIndexedSubscript:) swizzleSel:@selector(ddy_ObjectAtIndexedSubscript:)];
        // MARK: getObjects:range:
        [_NSArray ddy_SwapMethod:@selector(getObjects:range:) swizzleSel:@selector(ddy_NSArrayGetObjects:range:)];
        [_NSArrayI ddy_SwapMethod:@selector(getObjects:range:) swizzleSel:@selector(ddy_NSArrayIGetObjects:range:)];
        [_NSArraySingleObjectArrayI ddy_SwapMethod:@selector(getObjects:range:) swizzleSel:@selector(ddy_NSArraySingleGetObjects:range:)];
    });
}

+ (instancetype)ddy_ArrayWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self ddy_ArrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        NSUInteger newIndex = 0;
        id _Nonnull __unsafe_unretained newObjects[cnt];
        for (int i = 0; i < cnt; i++) {
            if (objects[i]) {
                newObjects[newIndex] = objects[i];
                newIndex ++;
            }
        }
        instance = [self ddy_ArrayWithObjects:newObjects count:newIndex];
    }
    @finally {
        return instance;
    }
}

- (NSArray *)ddy_ObjectsAtIndexes:(NSIndexSet *)indexes {
    NSArray *returnArray = nil;
    @try {
        returnArray = [self ddy_ObjectsAtIndexes:indexes];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return returnArray;
    }
}

- (id)ddy_NSArray0ObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self ddy_NSArray0ObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return object;
    }
}

- (id)ddy_NSArrayIObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self ddy_NSArrayIObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return object;
    }
}

- (id)ddy_NSArraySingleObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self ddy_NSArraySingleObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return object;
    }
}

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

- (void)ddy_NSArrayGetObjects:(__unsafe_unretained id  _Nonnull [])objects range:(NSRange)range {
    @try {
        [self ddy_NSArrayGetObjects:objects range:range];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

- (void)ddy_NSArrayIGetObjects:(__unsafe_unretained id  _Nonnull [])objects range:(NSRange)range {
    @try {
        [self ddy_NSArrayIGetObjects:objects range:range];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

- (void)ddy_NSArraySingleGetObjects:(__unsafe_unretained id  _Nonnull [])objects range:(NSRange)range {
    @try {
        [self ddy_NSArraySingleGetObjects:objects range:range];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

@end

