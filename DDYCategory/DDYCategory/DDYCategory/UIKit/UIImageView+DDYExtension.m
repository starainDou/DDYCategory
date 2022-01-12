#import "UIImageView+DDYExtension.h"
#import <objc/runtime.h>
#import "UIImage+DDYExtension.h"

@implementation UIImageView (DDYExtension)

static BOOL isAllShowGrayImage = NO;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self changeOrignalSEL:@selector(setImage:) swizzleSEL:@selector(ddy_setimage:)];
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

/// 全部启用灰度图
+ (void)allShowGrayImage:(BOOL)showGrayImage {
    isAllShowGrayImage = showGrayImage;
}

- (void)ddy_setimage:(UIImage *)image {
    [self ddy_setimage: (isAllShowGrayImage && self.isShowGrayImage) ? [image grayImage] : image];
}

- (BOOL)isShowGrayImage {
    NSNumber *number = objc_getAssociatedObject(self, "ddyIsShowGrayImage");
    return number ? [number boolValue] : NO;
}

- (void)setIsShowGrayImage:(BOOL)isShowGrayImage {
    NSNumber *number = [NSNumber numberWithBool: isShowGrayImage];
    objc_setAssociatedObject(self, "ddyIsShowGrayImage", number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
