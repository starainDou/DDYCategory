

#import "LinkBlockDefine.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface NSObject(JSValueLinkBlock)
/** <^(id owner)> */
LBDeclare JSManagedValue*      (^jsValueToManagedValue)(id owner);
/** <^(id owner)> */
LBDeclare JSValue*             (^jsValueAddToSelfManagedRef)(id owner);
/** <^(NSArray* args)> */
LBDeclare JSValue*             (^jsValueCallFunc)(NSArray* args);
@end
