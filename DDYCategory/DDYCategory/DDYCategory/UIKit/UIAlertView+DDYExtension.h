//
//  UIAlertView+DDYExtension.h
//  DDYCategory
//
//  Created by SmartMesh on 2018/7/13.
//  Copyright © 2018年 com.smartmesh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickButtonIndexBlock) (NSInteger index);

@interface UIAlertView (DDYExtension)

/**
 block回调替代delegate
 @param title alertTitle
 @param message alertContentMessage
 @param cancelTitle alertCancelTitle
 @param otherTitle alertOtherButtonTitle
 @param clickIndex 点击回调 返回点击index
 @return UIAlertView实例对象
 */
+ (UIAlertView *)ddy_AlertTitle:(NSString *)title
                        message:(NSString *)message
                    cancelTitle:(NSString *)cancelTitle
                     otherTitle:(NSString *)otherTitle
                     clickIndex:(ClickButtonIndexBlock)clickIndex;

@end
