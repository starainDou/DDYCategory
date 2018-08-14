#import <Foundation/Foundation.h>

@interface NSObject (DDYSafe)

/** 开启安全处理 防止常见崩溃 */
+ (void)ddy_SafeEffect;

/** 发送通知 */
- (void)ddy_HandleException:(NSException *)exception defaultSolution:(NSString *)solution;

/** 添加方法 */
+ (void)ddy_AddMethod:(SEL)methodSel methodImp:(SEL)methodImp;

/** 交换实例方法 */
+ (void)ddy_SwapMethod:(SEL)originalSel swizzleSel:(SEL)swizzleSel;

/** 交换类方法 */
+ (void)ddy_SwapClassMethod:(SEL)originalSel swizzleSel:(SEL)swizzleSel;

@end
