
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DDYPresent)

/// 如果以后迭代版本想全部用系统原来样式，统一返回NO即可
/// rentrn BOOL UIImagePickerController/UIAlertController is NO，others is YES
+ (BOOL)ddy_GlobalAutoSetModalPresentationStyle;

/// 具体某个控制器不想更改了(想用系统默认)设置NO
/// return BOOL [Class ddy_GlobalAutoSetModalPresentationStyle];
@property (nonatomic, assign) BOOL ddy_AutoSetModalPresentationStyle;

@end

NS_ASSUME_NONNULL_END

/**
 一个一个改浪费时间，适合版本迭代中逐步替换；
 直接重写-modalPresentationStyle 侵入性太大，造成系统弹出也被重置，或者某个控制器想改变样式都不能，不太友好
 所有用一个类方法控制全局，一个实例方法控制具体某个控制器实例样式。
 */
