#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (DDYSafe)

/** 开启安全处理 防止常见崩溃 */
+ (void)ddy_SafeEffect;

@end
