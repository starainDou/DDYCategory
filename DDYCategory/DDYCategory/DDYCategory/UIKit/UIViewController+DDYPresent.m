#import "UIViewController+DDYPresent.h"
#import <objc/runtime.h>

@implementation UIViewController (DDYPresent)

+ (void)changeOriginalSEL:(SEL)orignalSEL swizzledSEL:(SEL)swizzledSEL {
    Method originalMethod = class_getInstanceMethod([self class], orignalSEL);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSEL);
    if (class_addMethod([self class], orignalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod([self class], swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSEL = @selector(presentViewController:animated:completion:);
        SEL swizzledSEL = @selector(ddy_PresentViewController:animated:completion:);
        [self changeOriginalSEL:originalSEL swizzledSEL:swizzledSEL];
    });
}

- (void)ddy_PresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *)) {
        if (viewControllerToPresent.ddy_AutoSetModalPresentationStyle) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    [self ddy_PresentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)setDdy_AutoSetModalPresentationStyle:(BOOL)ddy_AutoSetModalPresentationStyle {
    objc_setAssociatedObject(self, @selector(ddy_AutoSetModalPresentationStyle), @(ddy_AutoSetModalPresentationStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)ddy_AutoSetModalPresentationStyle {
    NSNumber *obj = objc_getAssociatedObject(self, @selector(ddy_AutoSetModalPresentationStyle));
    return obj ? [obj boolValue] : [self.class ddy_GlobalAutoSetModalPresentationStyle];
}

+ (BOOL)ddy_GlobalAutoSetModalPresentationStyle {
    if ([self isKindOfClass:[UIImagePickerController class]]) {
        return NO;
    } else if ([self isKindOfClass:[UIAlertController class]]) {
        return NO;
    }
    return YES;
}

@end
