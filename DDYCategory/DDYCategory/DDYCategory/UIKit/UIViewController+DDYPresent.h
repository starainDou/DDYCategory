
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DDYPresent)

/// 自动调整模态弹出样式时要排除的控制器(如果未设置则使用内置)
/// @param controllerNameArray 模态弹出的控制器名称数组
+ (void)ddy_ExcludeControllerNameArray:(NSArray<NSString *> *)controllerNameArray;

/// 是否自动调整模态弹出全屏样式
/// NO:表示不自动调整，保持默认，可能全屏样式也可能其他样式
/// YES:表示调整为全屏样式
/// 如果是排除的控制器数组包含的控制器则默认NO
/// 如果不在排除的控制器数组内包含则默认YES
@property (nonatomic, assign) BOOL ddy_AutoSetModalPresentationStyleFullScreen;

@end

NS_ASSUME_NONNULL_END

/**
 一个一个改浪费时间，适合版本迭代中逐步替换；
 直接重写-modalPresentationStyle 侵入性太大，造成系统弹出也被重置，或者某个控制器想改变样式都不能，不太友好
 所有用一个类方法控制全局，一个实例方法控制具体某个控制器实例样式。
 */
