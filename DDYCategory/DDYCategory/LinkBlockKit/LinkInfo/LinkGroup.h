


#import "LinkBlockDefine.h"

typedef NS_OPTIONS(NSUInteger, LinkGroupHandleType) {
    LinkGroupHandleTypeNone                 = 0,
    /** 原链条数 */
    LinkGroupHandleTypeLoopOriginCount      = 1 << 0
};

@interface LinkGroup : LinkInfo
@property (nonatomic,strong) NSMutableArray<NSObject*>* linkObjects;

+ (LinkGroup*)group;
+ (LinkGroup*)groupWithObjs:(id)obj,...;
+ (LinkGroup*)groupWithObjs:(id)obj0 args:(va_list)args;
+ (LinkGroup*)groupWithArr:(NSArray*)obj;
@end
