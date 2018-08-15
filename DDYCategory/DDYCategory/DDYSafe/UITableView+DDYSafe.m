#import "UITableView+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation UITableView (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] ddy_SwapMethod:@selector(reloadData) swizzleSel:@selector(ddy_ReloadData)];
    });
}

- (void)ddy_ReloadData {
    if ([NSThread mainThread]) {
        [self ddy_ReloadData];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ddy_ReloadData];
        });
    }
}

@end
