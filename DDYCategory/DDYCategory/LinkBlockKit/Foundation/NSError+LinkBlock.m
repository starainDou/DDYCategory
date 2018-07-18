


#import "LinkBlock.h"

@implementation NSObject(NSErrorLinkBlock)
- (NSObject *(^)(id<NSCopying>))errorValueInUserInfo
{
    return ^id(id<NSCopying> key){
        LinkHandle_REF(NSError)
        LinkGroupHandle_REF(errorValueInUserInfo,key)
        return _self.userInfo[key];
    };
}
@end
