#import "UISearchBar+DDYExtension.h"
#import <objc/runtime.h>

@implementation UISearchBar (DDYExtension)

// MARK: 解决iOS13兼容
- (UITextField *)ddy_SearchField {
#ifdef __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        return self.searchTextField;
    }
#endif
    return [self valueForKey:@"_searchField"];
}

- (UILabel *)ddy_PlaceholderLabel {
    UITextField *textField = [self ddy_SearchField];
    Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(textField, ivar);
    return placeholderLabel;
}

@end
