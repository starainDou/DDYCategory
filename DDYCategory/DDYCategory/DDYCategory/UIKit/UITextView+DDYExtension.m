#import "UITextView+DDYExtension.h"
#import <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation UITextView (DDYExtension)

- (void)adjustPlaceholderLabel {
    [self.placeholderLabel setFont:self.placeholderFont];
    [self.placeholderLabel setTextColor:self.placeholderColor];
    [self.placeholderLabel setFrame:CGRectMake(self.textContainerInset.left,
                                               self.textContainerInset.top,
                                               self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right,
                                               self.bounds.size.height - self.textContainerInset.top - self.textContainerInset.bottom)];
    [self.placeholderLabel sizeToFit];
}

#pragma mark 添加给系统属性 _placeholderLabel 在iOS8.3以上版本才有
- (void)addToSystemPlaceholderLabel:(UILabel *)label {
    if (@available(iOS 8.3, *)) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(NSClassFromString(@"UITextView"), &count);
        for(int i =0; i < count; i ++) {
            NSString *ivarName = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
            if ([ivarName isEqualToString:@"_placeholderLabel"]) {
                [self setValue:label forKey:@"_placeholderLabel"];
            }
        }
        free(ivars);
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ddy_TextViewDidChange:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
    }
}

- (UILabel *)placeholderLabel {
    UILabel *placeholderLabel = objc_getAssociatedObject(self, @selector(placeholderLabel));
    if (!placeholderLabel) {
        placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.textAlignment = self.textAlignment;
        [self addSubview:placeholderLabel];
        [self setPlaceholderLabel:placeholderLabel];
        [self addToSystemPlaceholderLabel:placeholderLabel];
    }
    return placeholderLabel;
}

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self, @selector(placeholderLabel), placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)placeholder {
    return objc_getAssociatedObject(self, @selector(placeholder));
}

- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, @selector(placeholder), placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.placeholderLabel setText:self.placeholder];
    [self layoutIfNeeded];
}

- (UIColor *)placeholderColor {
    UIColor *placeholderColor = objc_getAssociatedObject(self, @selector(placeholderColor));
    if (!placeholderColor) {
        placeholderColor = [UIColor lightGrayColor];
    }
    return placeholderColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    objc_setAssociatedObject(self, @selector(placeholderColor), placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layoutIfNeeded];
}

- (UIFont *)placeholderFont {
    UIFont *placeholderFont = objc_getAssociatedObject(self, @selector(placeholderFont));
    if (!placeholderFont) {
        placeholderFont = [UIFont systemFontOfSize:12];
    }
    return placeholderFont;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    objc_setAssociatedObject(self, @selector(placeholderFont), placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layoutIfNeeded];
}

- (void)ddy_TextViewDidChange:(NSNotification *)notification {
    UITextView *textView = notification.object;
    self.placeholderLabel.hidden = textView.text.length>0 ? YES : NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self adjustPlaceholderLabel];
}

@end
