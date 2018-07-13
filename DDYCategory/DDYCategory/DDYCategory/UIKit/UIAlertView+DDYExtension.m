//
//  UIAlertView+DDYExtension.m
//  DDYCategory
//
//  Created by SmartMesh on 2018/7/13.
//  Copyright © 2018年 com.smartmesh. All rights reserved.
//

#import "UIAlertView+DDYExtension.h"
#import <objc/runtime.h>

@implementation UIAlertView (DDYExtension)

+ (UIAlertView *)ddy_AlertTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherTitle clickIndex:(ClickButtonIndexBlock)clickIndex {
    UIAlertView *alertView = [[self alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    alertView.delegate = alertView;
    [alertView show];
    objc_setAssociatedObject(alertView, "ddyAlertViewBlockKey", clickIndex, OBJC_ASSOCIATION_COPY);
    return alertView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ClickButtonIndexBlock block = objc_getAssociatedObject(alertView, "ddyAlertViewBlockKey");
    if (block) block(buttonIndex);
}

@end
