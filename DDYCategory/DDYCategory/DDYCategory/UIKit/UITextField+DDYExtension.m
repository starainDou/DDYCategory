#import "UITextField+DDYExtension.h"
#import <objc/runtime.h>

@implementation UITextField (DDYExtension)

+ (void)load {
    // 解决iOS10系统searchBar上TextField文字下沉3像素bug
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0 && [[UIDevice currentDevice].systemVersion floatValue] < 11.0){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self changeOrignalSEL:@selector(layoutSubviews) swizzleSEL:@selector(ddy_LayoutSubviews)];
        });
    }
}

+ (void)changeOrignalSEL:(SEL)orignalSEL swizzleSEL:(SEL)swizzleSEL {
    Method originalMethod = class_getInstanceMethod([self class], orignalSEL);
    Method swizzleMethod = class_getInstanceMethod([self class], swizzleSEL);
    if (class_addMethod([self class], orignalSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
        class_replaceMethod([self class], swizzleSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

- (void)ddy_LayoutSubviews {
    [self ddy_LayoutSubviews];
    for(UIScrollView *view in self.subviews) {
        if([view isKindOfClass:[UIScrollView class]]) {
            CGPoint offset = view.contentOffset;
            if(offset.y != 0) {
                offset.y = 0;
                view.contentOffset = offset;
            }
            break;
        }
    }
}

@end
