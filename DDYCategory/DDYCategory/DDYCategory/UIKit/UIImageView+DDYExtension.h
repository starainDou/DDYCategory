#import <UIKit/UIKit.h>

@interface UIImageView (DDYExtension)

/// 全部启用灰度图
+ (void)allShowGrayImage:(BOOL)showGrayImage;
/// 是否启用灰度图
@property (nonatomic, assign) BOOL isShowGrayImage;

@end
