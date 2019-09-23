#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBar (DDYExtension)

/// 解决iOS13兼容，获取textField
- (UITextField *)ddy_SearchField;
/// 解决iOS13兼容，获取placeholderLabel
- (UILabel *)ddy_PlaceholderLabel;

@end

NS_ASSUME_NONNULL_END
