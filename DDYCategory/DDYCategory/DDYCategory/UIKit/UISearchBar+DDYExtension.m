#import "UISearchBar+DDYExtension.h"
#import <objc/runtime.h>

@implementation UISearchBar (DDYExtension)

// MARK: 解决iOS13兼容
- (UITextField *)ddy_SearchField {
    if (@available(iOS 13.0, *)) {
        return self.searchTextField;
    } else {
        return [self valueForKey:@"_searchField"];
    }
}

- (UILabel *)ddy_PlaceholderLabel {
    UITextField *textField = [self ddy_SearchField];
    Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(textField, ivar);
    return placeholderLabel;
}

@end
