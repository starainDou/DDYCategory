#import <UIKit/UIKit.h>

@interface UITextField (DDYExtension)

/// 解决iOS13兼容，获取placeholderLabel
- (UILabel *)ddy_PlaceholderLabel;

@end
