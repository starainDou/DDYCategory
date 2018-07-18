


#import "LinkBlock.h"

@implementation NSObject(UIViewControllerLinkBlock)

- (UIViewController *(^)(UIViewController *))vcAddChildVC
{
    return ^id(UIViewController* childVC) {
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcAddChildVC,childVC)
        [_self addChildViewController:childVC];
        return _self;
    };
}

- (UIViewController *(^)(NSString *))vcTitle
{
    return ^id(NSString* title) {
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(vcTitle,title)
        _self.title = title;
        return _self;
    };
}

- (UIViewController *(^)(BOOL))hideBar
{
    return ^id(BOOL hide) {
        LinkHandle_REF(UIViewController)
        LinkGroupHandle_REF(hideBar,hide)
        _self.hidesBottomBarWhenPushed = hide;
        return _self;
    };
}

@end
