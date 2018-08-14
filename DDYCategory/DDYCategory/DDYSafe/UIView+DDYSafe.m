#import "UIView+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation UIView (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] ddy_SwapMethod:@selector(setNeedsLayout) swizzleSel:@selector(ddy_SetNeedsLayout)];
        [[self class] ddy_SwapMethod:@selector(setNeedsDisplay) swizzleSel:@selector(ddy_SetNeedsDisplay)];
        [[self class] ddy_SwapMethod:@selector(setNeedsDisplayInRect:) swizzleSel:@selector(ddy_SetNeedsDisplayInRect:)];
        [[self class] ddy_SwapMethod:@selector(setNeedsUpdateConstraints) swizzleSel:@selector(ddy_SetNeedsUpdateConstraints)];
    });
}

- (void)ddy_SetNeedsLayout {
    if ([NSThread mainThread]) {
        [self ddy_SetNeedsLayout];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ddy_SetNeedsLayout];
        });
    }
}

- (void)ddy_SetNeedsDisplay {
    if ([NSThread mainThread]) {
        [self ddy_SetNeedsDisplay];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ddy_SetNeedsDisplay];
        });
    }
}

- (void)ddy_SetNeedsDisplayInRect:(CGRect)rect {
    if ([NSThread mainThread]) {
        [self ddy_SetNeedsDisplayInRect:rect];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ddy_SetNeedsDisplayInRect:rect];
        });
    }
}

- (void)ddy_SetNeedsUpdateConstraints {
    if ([NSThread mainThread]) {
        [self ddy_SetNeedsUpdateConstraints];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ddy_SetNeedsUpdateConstraints];
        });
    }
}


@end
