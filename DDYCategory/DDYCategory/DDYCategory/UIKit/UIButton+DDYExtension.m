#import "UIButton+DDYExtension.h"
#import "UIView+DDYExtension.h"
#import "UIImage+DDYExtension.h"
#import <objc/runtime.h>

@implementation UIButton (DDYExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
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

- (void)ddy_LayoutSubviews {
    [self ddy_LayoutSubviews];
    
    if (self.imageView.image && self.titleLabel.text)
    {
        switch (self.btnStyle)
        {
            case DDYBtnStyleImgLeft:
                [self layoutHorizontalWithLeftView:self.imageView rightView:self.titleLabel];
                break;
            case DDYBtnStyleImgRight:
                [self layoutHorizontalWithLeftView:self.titleLabel rightView:self.imageView];
                break;
            case DDYBtnStyleImgTop:
                [self layoutVerticalWithUpView:self.imageView downView:self.titleLabel];
                break;
            case DDYBtnStyleImgDown:
                [self layoutVerticalWithUpView:self.titleLabel downView:self.imageView];
                break;
            case DDYBtnStyleNaturalImgLeft:
                [self layoutNaturalWithLeftView:self.imageView rightView:self.titleLabel];
                break;
            case DDYBtnStyleNaturalImgRight:
                [self layoutNaturalWithLeftView:self.titleLabel rightView:self.imageView];
                break;
            case DDYBtnStyleImgLeftThenLeft:
                [self layoutLeftStyleWithLeftView:self.imageView rightView:self.titleLabel];
                break;
            case DDYBtnStyleImgRightThenLeft:
                [self layoutLeftStyleWithLeftView:self.titleLabel rightView:self.imageView];
                break;
            case DDYBtnStyleImgRightThenRight:
                [self layoutRightStyleWithLeftView:self.titleLabel rightView:self.imageView];
                break;
            case DDYBtnStyleImgLeftThenRight:
                [self layoutRightStyleWithLeftView:self.imageView rightView:self.titleLabel];
                break;
            default:
                [self layoutHorizontalWithLeftView:self.imageView rightView:self.titleLabel];
                break;
        }
    }
}

- (void)layoutHorizontalWithLeftView:(UIView *)leftView rightView:(UIView *)rightView {
    CGFloat totalW = leftView.ddy_w + self.padding + rightView.ddy_w;
    
    leftView.ddy_x = (self.ddy_w - totalW)/2.0;
    leftView.ddy_y = (self.ddy_h - leftView.ddy_h)/2.0;
    rightView.ddy_x = leftView.ddy_right + self.padding;
    rightView.ddy_y = (self.ddy_h - rightView.ddy_h)/2.0;
}

- (void)layoutVerticalWithUpView:(UIView *)upView downView:(UIView *)downView {
    CGFloat totalH = upView.ddy_h + self.padding + downView.ddy_h;
    
    upView.ddy_x = (self.ddy_w - upView.ddy_w)/2.0;
    upView.ddy_y = (self.ddy_h - totalH)/2.0;
    downView.ddy_x = (self.ddy_w - downView.ddy_w)/2.0;
    downView.ddy_y = upView.ddy_bottom + self.padding;
}

- (void)layoutNaturalWithLeftView:(UIView *)leftView rightView:(UIView *)rightView {
    leftView.ddy_x = 0;
    rightView.ddy_right = self.ddy_w;
}

- (void)layoutLeftStyleWithLeftView:(UIView *)leftView rightView:(UIView *)rightView {
    leftView.ddy_x = 0;
    rightView.ddy_x = leftView.ddy_right + self.padding;
}

- (void)layoutRightStyleWithLeftView:(UIView *)leftView rightView:(UIView *)rightView {
    rightView.ddy_right = self.ddy_w;
    leftView.ddy_right = rightView.ddy_x - self.padding;
}

- (void)setBtnStyle:(DDYBtnStyle)btnStyle {
    NSNumber *number = [NSNumber numberWithInteger:(NSInteger)btnStyle];
    objc_setAssociatedObject(self, "ddyBtnStyleKey", number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (DDYBtnStyle)btnStyle {
    NSNumber *number = objc_getAssociatedObject(self, "ddyBtnStyleKey");
    return number ? (DDYBtnStyle)[number integerValue] : DDYBtnStyleImgLeft;
}

- (void)setPadding:(CGFloat)padding {
    NSNumber *number = [NSNumber numberWithFloat:padding];
    objc_setAssociatedObject(self, "ddyPaddingKey", number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (CGFloat)padding {
    NSNumber *number = objc_getAssociatedObject(self, "ddyPaddingKey");
    return number ? [number floatValue] : 0.f;
}

- (void)ddy_SetStyle:(DDYBtnStyle)style padding:(CGFloat)padding {
    self.btnStyle = style;
    self.padding = padding;
}

#pragma mark - 对touchUpInside进行block
- (void)ddy_TouchUpInsideBlock:(DDYButtonTouchUpInsideBlock)block {
    if (block) objc_setAssociatedObject(self, "DDYTouchUpInsideKey", block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleTouchUpInside:(UIButton *)sender {
    DDYButtonTouchUpInsideBlock block = objc_getAssociatedObject(self, "DDYTouchUpInsideKey");
    block(sender);
}

#pragma mark 使用颜色设置按钮背景
- (void)ddy_BackgroundColor:(UIColor *)bgColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage ddy_RectImageWithColor:bgColor size:CGSizeMake(1, 1)] forState:state];
}

@end
