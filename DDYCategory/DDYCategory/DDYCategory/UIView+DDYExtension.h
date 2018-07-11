//
//  UIView+DDYExtension.h
//  DDYCategory
//
//  Created by SmartMesh on 2018/7/11.
//  Copyright © 2018年 com.smartmesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DDYExtension)

#pragma mark - ---------------- 布局 ------------------

@property (nonatomic, assign) CGFloat ddy_x;
@property (nonatomic, assign) CGFloat ddy_y;
@property (nonatomic, assign) CGFloat ddy_w;
@property (nonatomic, assign) CGFloat ddy_h;
@property (nonatomic, assign) CGFloat ddy_right;
@property (nonatomic, assign) CGFloat ddy_bottom;
@property (nonatomic, assign) CGFloat ddy_centerX;
@property (nonatomic, assign) CGFloat ddy_centerY;
@property (nonatomic, assign) CGSize  ddy_size;
@property (nonatomic, assign) CGPoint ddy_origin;

#pragma mark - ---------------- 手势 ------------------
/** 点击手势 */
- (void)ddy_AddTapTarget:(id)target action:(SEL)action;
/** 点击手势 + 代理 */
- (void)ddy_AddTapTarget:(id)target action:(SEL)action delegate:(id)delegate;
/** 点击手势 + 点击数 */
- (void)ddy_AddTapTarget:(id)target action:(SEL)action number:(NSInteger)number;
/** 点击手势 + 点击数 + 代理 */
- (void)ddy_AddTapTarget:(id)target action:(SEL)action number:(NSInteger)number  delegate:(id)delegate;
/** 长按手势 */
- (void)ddy_AddLongGestureTarget:(id)target action:(SEL)action;
/** 长按手势 + 长按最短时间 */
- (void)ddy_AddLongGestureTarget:(id)target action:(SEL)action minDuration:(CFTimeInterval)minDuration;
/** 拖动手势 */
- (void)ddy_AddPanGestureTarget:(id)target action:(SEL)action;
/** 拖动手势 + 代理 */
- (void)ddy_AddPanGestureTarget:(id)target action:(SEL)action delegate:(id)delegate;

#pragma mark - ---------------- 截屏 ------------------
/** 截屏生成图片 */
- (nullable UIImage *)ddy_SnapshotImage;
/** 截屏生成PDF */
- (nullable NSData *)ddy_SnapshotPDF;

#pragma mark - ---------------- UI ------------------
/** 阴影 */
- (void)ddy_LayerShadow:(nullable UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;
/** 部分圆角 UIRectCornerBottomLeft | UIRectCornerBottomRight */
- (void)ddy_RoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;

#pragma mark - ---------------- 功能 ------------------
/** 移除所有子视图 */
- (void)ddy_RemoveAllChildView;
/** 根据tag找到某个子视图 */
- (nullable id)ddy_SubviewWithTag:(NSInteger)tag;
/** 找到视图所在视图控制器 */
- (nullable UIViewController *)ddy_GetViewController;
/** 找到视图所在可相应的控制器 */
- (nullable UIViewController *)ddy_GetResponderViewController;
/** 本视图上的点坐标在某个view上的相对坐标 */
- (CGPoint)ddy_ConvertPoint:(CGPoint)point toView:(nullable UIView *)view;
/** 某个view上的点坐标在本视图上的相对坐标 */
- (CGPoint)ddy_ConvertPoint:(CGPoint)point fromView:(nullable UIView *)view;
/** 本视图上的rect在某个view上的相对rect */
- (CGRect)ddy_ConvertRect:(CGRect)rect toView:(nullable UIView *)view;
/** 某个view上的rect在本视图上的相对rect */
- (CGRect)ddy_ConvertRect:(CGRect)rect fromView:(nullable UIView *)view;


@end
