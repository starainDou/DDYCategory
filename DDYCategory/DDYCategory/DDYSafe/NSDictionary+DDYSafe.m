#import "NSDictionary+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation NSDictionary (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ddy_SwapClassMethod:@selector(dictionaryWithObjects:forKeys:count:) swizzleSel:@selector(ddy_DictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)ddy_DictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self ddy_DictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        NSUInteger newIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[newIndex] = objects[i];
                newkeys[newIndex] = keys[i];
                newIndex ++;
            }
        }
        instance = [self ddy_DictionaryWithObjects:newObjects forKeys:newkeys count:newIndex];
    }
    @finally {
        return instance;
    }
}

@end
