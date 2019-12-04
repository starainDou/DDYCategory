#import "UIButton+DDYExtension.h"
#import <objc/runtime.h>

@implementation UIButton (DDYExtension)

// MARK: 方法交换
// MARK: 第一次加载时完成方法交换
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self changeOrignalSEL:@selector(layoutSubviews) swizzleSEL:@selector(ddy_LayoutSubviews)];
        [self changeOrignalSEL:@selector(hitTest:withEvent:) swizzleSEL:@selector(ddy_HitTest:withEvent:)];
    });
}

// MARK: 方法交换功能
+ (void)changeOrignalSEL:(SEL)orignalSEL swizzleSEL:(SEL)swizzleSEL {
    Method originalMethod = class_getInstanceMethod([self class], orignalSEL);
    Method swizzleMethod = class_getInstanceMethod([self class], swizzleSEL);
    if (class_addMethod([self class], orignalSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
        class_replaceMethod([self class], swizzleSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

// MARK: - 设置图文位置
// MARK: 交换布局方法
- (void)ddy_LayoutSubviews {
    [self ddy_LayoutSubviews];
    
    if (self.imageView && self.imageView.image && self.titleLabel && self.titleLabel.text) {
        switch (self.btnStyle) {
            case DDYBtnStyleImgLeft:
                [self layoutHorizontalWithLeftView:self.imageView rightView:self.titleLabel];
                break;
            case DDYBtnStyleImgRight:
                [self layoutHorizontalWithLeftView:self.titleLabel rightView:self.imageView];
                break;
            case DDYBtnStyleImgTop:
                [self layoutVerticalWithTopView:self.imageView bottomView:self.titleLabel];
                break;
            case DDYBtnStyleImgDown:
                [self layoutVerticalWithTopView:self.titleLabel bottomView:self.imageView];
                break;
            default:
                break;
        }
    }
}

// MARK: 横向布局
- (void)layoutHorizontalWithLeftView:(UIView *)leftView rightView:(UIView *)rightView {
    [self.titleLabel sizeToFit];
    // 内容实际宽高
    CGFloat contentW = leftView.bounds.size.width + self.padding + rightView.bounds.size.width;
    CGFloat contentH = MAX(leftView.bounds.size.height, rightView.bounds.size.height);
    // 加上内边距后按钮宽高
    CGFloat buttonW = contentW + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    CGFloat buttonH = contentH + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
    // 左边视图起始位置
    CGFloat leftViewX = self.contentEdgeInsets.left;
    CGFloat leftViewY = (contentH-leftView.bounds.size.height)/2.0 + self.contentEdgeInsets.top;
    // 右边视图起始位置
    CGFloat rightViewX = self.contentEdgeInsets.left + self.padding + leftView.bounds.size.width;
    CGFloat rightViewY = (contentH-rightView.bounds.size.height)/2.0 + self.contentEdgeInsets.top;
    // 调整bounds
    self.bounds = CGRectMake(0, 0, buttonW, buttonH);
    leftView.frame = CGRectMake(leftViewX, leftViewY, leftView.bounds.size.width, leftView.bounds.size.height);
    rightView.frame = CGRectMake(rightViewX, rightViewY, rightView.bounds.size.width, rightView.bounds.size.height);
}

// MARK: 纵向布局
- (void)layoutVerticalWithTopView:(UIView *)topView bottomView:(UIView *)bottomView {
    [self.titleLabel sizeToFit];
    // 内容实际宽高
    CGFloat contentW = MAX(topView.bounds.size.width, bottomView.bounds.size.width);
    CGFloat contentH = topView.bounds.size.height + self.padding + bottomView.bounds.size.height;
    // 加上内边距后按钮宽高
    CGFloat buttonW = contentW + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    CGFloat buttonH = contentH + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
    // 上边视图起始位置
    CGFloat topViewX = (contentW-topView.bounds.size.width)/2.0 + self.contentEdgeInsets.left;
    CGFloat topViewY = self.contentEdgeInsets.top;
    // 下边视图起始位置
    CGFloat bottomViewX = (contentW-bottomView.bounds.size.width)/2.0 + self.contentEdgeInsets.left;
    CGFloat bottomViewY = self.contentEdgeInsets.top + self.padding + topView.bounds.size.height;
    // 调整bounds
    self.bounds = CGRectMake(0, 0, buttonW, buttonH);
    topView.frame = CGRectMake(topViewX, topViewY, topView.bounds.size.width, topView.bounds.size.height);
    bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomView.bounds.size.width, bottomView.bounds.size.height);
}

// MARK: 设置图文样式Setter
- (void)setBtnStyle:(DDYBtnStyle)btnStyle {
    NSNumber *number = [NSNumber numberWithInteger:(NSInteger)btnStyle];
    objc_setAssociatedObject(self, "ddyBtnStyleKey", number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

// MARK: 获取图文样式Getter
- (DDYBtnStyle)btnStyle {
    NSNumber *number = objc_getAssociatedObject(self, "ddyBtnStyleKey");
    return number ? (DDYBtnStyle)[number integerValue] : DDYBtnStyleDefault;
}

// MARK: 设置图文间距Setter
- (void)setPadding:(CGFloat)padding {
    NSNumber *number = [NSNumber numberWithFloat:padding];
    objc_setAssociatedObject(self, "ddyPaddingKey", number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

// MARK: 获取图文间距Getter
- (CGFloat)padding {
    NSNumber *number = objc_getAssociatedObject(self, "ddyPaddingKey");
    return number ? [number floatValue] : 0.5f;
}

// MARK: 同时一个方法内设置图文样式和图文间距
- (void)ddy_SetStyle:(DDYBtnStyle)style padding:(CGFloat)padding {
    self.btnStyle = style;
    self.padding = padding;
}

// MARK: - 对touchUpInside进行block
// MARK: 设置touchUpInside回调的block
- (void)ddy_TouchUpInsideBlock:(DDYButtonTouchUpInsideBlock)block {
    if (block) objc_setAssociatedObject(self, "DDYTouchUpInsideKey", block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

// MARK: 事件回调
- (void)handleTouchUpInside:(UIButton *)sender {
    DDYButtonTouchUpInsideBlock block = objc_getAssociatedObject(self, "DDYTouchUpInsideKey");
    if (block) {
        block(sender);
    }
}

// MARK: - 使用颜色设置按钮背景
// MARK: 设置颜色背景(state 位移枚举)
// 0/1/10/11/100/101/110/111/1000/1001/1010/1011/1100/1101/1110/1111
- (void)ddy_BackgroundColor:(UIColor *)bgColor forState:(UIControlState)state {
    if (!bgColor) {
        return;
    }
    NSDictionary *localInfo = objc_getAssociatedObject(self, "DDYBackgroundImageColorInfo") ?:[NSDictionary dictionary];
    NSMutableDictionary *tempInfo = [NSMutableDictionary dictionaryWithDictionary:localInfo];
    tempInfo[[NSString stringWithFormat:@"%ld",(long)state]] = bgColor;
    objc_setAssociatedObject(self, "DDYBackgroundImageColorInfo", tempInfo, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setBackgroundImage:[self ddy_RectImageWithColor:bgColor size:CGSizeMake(1, 1)] forState:state];
}

// MARK: 内部更改DarkMode切换时背景
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    NSDictionary *infoDict = objc_getAssociatedObject(self, "DDYBackgroundImageColorInfo");
    if (infoDict && [infoDict isKindOfClass:[NSDictionary class]]) {
        [infoDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, UIColor *bgColor, BOOL *stop) {
            [self ddy_BackgroundColor:bgColor forState:[key integerValue]];
        }];
    }
}

// MARK: 绘制矩形图片
- (UIImage *)ddy_RectImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// MARK: 扩大热区
// MARK: 热区扩大内边距Setter
- (void)setDdyEnlargedEdge:(UIEdgeInsets)ddyEnlargedEdge {
    objc_setAssociatedObject(self, @selector(ddyEnlargedEdge), NSStringFromUIEdgeInsets(ddyEnlargedEdge), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// MARK: 获取扩大的热区内边距Getter
- (UIEdgeInsets)ddyEnlargedEdge {
    NSString *ddyEnlargedEdgeString = objc_getAssociatedObject(self, @selector(ddyEnlargedEdge));
    if (!ddyEnlargedEdgeString) {
        ddyEnlargedEdgeString = NSStringFromUIEdgeInsets(UIEdgeInsetsZero);
        objc_setAssociatedObject(self, @selector(ddyEnlargedEdge), ddyEnlargedEdgeString, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return UIEdgeInsetsFromString(ddyEnlargedEdgeString);
}

// MARK: 交换hit
- (UIView *)ddy_HitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [self ddy_HitTest:point withEvent:event];
    if (UIEdgeInsetsEqualToEdgeInsets(self.ddyEnlargedEdge, UIEdgeInsetsZero)) {
        return hitView;
    } else if (self.alpha<=0.01 || !self.userInteractionEnabled || self.hidden) {
        return hitView;
    } else {
        CGRect enlargedRect = CGRectMake(self.bounds.origin.x - ABS(self.ddyEnlargedEdge.left),
                                         self.bounds.origin.y - ABS(self.ddyEnlargedEdge.top),
                                         self.bounds.size.width + self.ddyEnlargedEdge.left + self.ddyEnlargedEdge.right,
                                         self.bounds.size.height + self.ddyEnlargedEdge.top + self.ddyEnlargedEdge.bottom);
        return CGRectContainsPoint(enlargedRect, point) ? self : hitView;
    }
}

@end
