#import "LinkBlockDefine.h"

#ifndef UIViewControllerNew
#define UIViewControllerNew ([UIViewController new])
#endif
@interface NSObject(UIViewControllerLinkBlock)
/** <^(UIViewController* childVC)> */
LBDeclare UIViewController*    (^vcAddChildVC)(UIViewController* childVC);
/** <^(NSString* title)> */
LBDeclare UIViewController*    (^vcTitle)(NSString* title);

LBDeclare UIViewController*     (^hideBar)(BOOL hide);

@end
