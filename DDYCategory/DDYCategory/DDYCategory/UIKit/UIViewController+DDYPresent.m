#import "UIViewController+DDYPresent.h"
#import <objc/runtime.h>

@implementation UIViewController (DDYPresent)

static NSArray *excludeControllerNameArray;

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
        if (viewControllerToPresent.ddy_AutoSetModalPresentationStyleFullScreen) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    [self ddy_PresentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)setDdy_AutoSetModalPresentationStyleFullScreen:(BOOL)ddy_AutoSetModalPresentationStyleFullScreen {
    objc_setAssociatedObject(self, @selector(ddy_AutoSetModalPresentationStyleFullScreen), @(ddy_AutoSetModalPresentationStyleFullScreen), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)ddy_AutoSetModalPresentationStyleFullScreen {
    NSNumber *obj = objc_getAssociatedObject(self, @selector(ddy_AutoSetModalPresentationStyleFullScreen));
    return obj ? [obj boolValue] : ![UIViewController ddy_IsExcludeSetModalPresentationStyleFullScreen:NSStringFromClass(self.class)];
}

// MARK: - 类方法
// MARK: 全局设置排除的控制器
+ (void)ddy_ExcludeControllerNameArray:(NSArray<NSString *> *)controllerNameArray {
    excludeControllerNameArray = controllerNameArray;
}

// MARK: 如果没有外部设置则使用内置的排除数组
+ (NSArray<NSString *> *)ddy_InnerExcludeControllerNameArray {
    NSMutableArray *nameArray = [NSMutableArray array];
    [nameArray addObject:@"UIImagePickerController"];
    [nameArray addObject:@"UIAlertController"];
    [nameArray addObject:@"UIActivityViewController"];
    [nameArray addObject:@"UIDocumentInteractionController"];
    [nameArray addObject:@"SLComposeViewController"]; //  #import <Social/Social.h>
    [nameArray addObject:@"SLComposeServiceViewController"]; // #import <Social/Social.h>
    [nameArray addObject:@"UIMenuController"];
    [nameArray addObject:@"SFSafariViewController"]; // API_AVAILABLE(ios(9.0)) #import <SafariServices/SafariServices.h>
    [nameArray addObject:@"SKStoreReviewController"]; // API_AVAILABLE(ios(10.3), macos(10.14)) #import <StoreKit/StoreKit.h>
    [nameArray addObject:@"SKStoreProductViewController"]; // API_AVAILABLE(ios(6.0)) #import <StoreKit/StoreKit.h>
    return nameArray;
}

// MARK: 是否是要排除自动设置的控制器
+ (BOOL)ddy_IsExcludeSetModalPresentationStyleFullScreen:(NSString *)className {
    NSArray *nameArray = excludeControllerNameArray ?: [UIViewController ddy_InnerExcludeControllerNameArray];
    return [nameArray containsObject:className];
}

@end
