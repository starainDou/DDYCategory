

#import "LinkBlockDefine.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface NSObject(JSManagedValueLinkBlock)
/** <^(JSVirtualMachine* virtualMachine, id owner)> */
LBDeclare JSManagedValue* (^jsManagedValueAddToManagedRef)(JSVirtualMachine* virtualMachine, id owner);
@end
