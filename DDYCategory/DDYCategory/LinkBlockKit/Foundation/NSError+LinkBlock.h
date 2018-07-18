


#import "LinkBlockDefine.h"

@interface NSObject(NSErrorLinkBlock)
/** <^(id<NSCopying> key)> */
LBDeclare NSObject*           (^errorValueInUserInfo)(id<NSCopying> key);
@end
