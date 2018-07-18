

#import "LinkBlock.h"

@implementation NSObject(JSManagedValueLinkBlock)
- (JSManagedValue *(^)(JSVirtualMachine *,id))jsManagedValueAddToManagedRef
{
    return ^id(JSVirtualMachine* virtualMachine,id owner){
        
        LinkHandle_REF(JSManagedValue)
        LinkGroupHandle_REF(jsManagedValueAddToManagedRef,virtualMachine,owner)
        [virtualMachine addManagedReference:_self withOwner:owner];
        return _self;
    };
}

@end
