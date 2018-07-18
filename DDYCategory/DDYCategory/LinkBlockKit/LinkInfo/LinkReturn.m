


#import "LinkReturn.h"

@implementation LinkReturn
- (instancetype)init
{
    self = [super init];
    if (self) {
        _infoType = LinkInfoReturn;
        _returnType = LinkReturnLink;
    }
    return self;
}
- (instancetype)initWithReturnValue:(id)returnValue
{
    if(self = [self init]){
        self.returnValue = returnValue;
    }
    return self;
}
- (instancetype)initWithReturnValue:(id)returnValue returnType:(LinkReturnType)returnType
{
    if(self = [self initWithReturnValue:returnValue]){
        self.returnType = returnType;
    }
    return self;
}
@end
