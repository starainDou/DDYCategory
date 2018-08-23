#import "UINavigationBar+DDYExtension.h"
#import <objc/runtime.h>

@implementation UINavigationBar (DDYExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self changeOrignalSEL:@selector(sizeThatFits:) swizzleSEL:@selector(ddy_SizeThatFits:)];
        [self changeOrignalSEL:@selector(layoutSubviews) swizzleSEL:@selector(ddy_LayoutSubviews)];
    });
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


- (CGSize)ddy_SizeThatFits:(CGSize)size {
    CGSize navigationBarSize = [self ddy_SizeThatFits:size];
    if (@available(iOS 11, *)) {
        navigationBarSize.height = navigationBarSize.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    return navigationBarSize;
}

- (void)ddy_LayoutSubviews {
    
    [self ddy_LayoutSubviews];
    if (@available(iOS 11, *)) {
        for (UIView *aView in self.subviews) {
            if ([@[@"_UINavigationBarBackground", @"_UIBarBackground"] containsObject:NSStringFromClass([aView class])]) {
                aView.frame = CGRectMake(0, -CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)+CGRectGetMinY(self.frame));
            }
        }
    }
}

@end
