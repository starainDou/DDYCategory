#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDYBtnStyle) {
    DDYBtnStyleDefault           = 0,     // 为了辨别默认状态
    DDYBtnStyleImgLeft           = 1,     // 左图右文，整体居中，设置间隙
    DDYBtnStyleImgRight          = 2,     // 左文右图，整体居中，设置间隙
    DDYBtnStyleImgTop            = 3,     // 上图下文，整体居中，设置间隙
    DDYBtnStyleImgDown           = 4,     // 下图上文，整体居中，设置间隙
};

typedef void(^DDYButtonTouchUpInsideBlock) (UIButton *sender);

@interface UIButton (DDYExtension)

/// 扩大热区
@property (nonatomic) UIEdgeInsets ddyEnlargedEdge;

/// 布局方式
@property (nonatomic, assign) DDYBtnStyle btnStyle;
/// 图文间距
@property (nonatomic, assign) CGFloat padding;

/// 快速同时设置布局方式和图文间距(图文都存在才有效)
/// @param style 布局样式
/// @param padding 图文间距
- (void)ddy_SetStyle:(DDYBtnStyle)style padding:(CGFloat)padding;

/// 用block替代 -addTarget:action:forControlEvents:UIControlEventTouchUpInside
/// @param block UIControlEventTouchUpInside事件回调
- (void)ddy_TouchUpInsideBlock:(DDYButtonTouchUpInsideBlock)block;

/// 使用颜色设置按钮背景
/// @param bgColor 背景色
/// @param state 对应状态
- (void)ddy_BackgroundColor:(UIColor *)bgColor forState:(UIControlState)state;


@end
