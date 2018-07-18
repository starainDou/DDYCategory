


#import "LinkBlockDefine.h"

@interface LinkError : LinkInfo
/** 需要类型 */
@property (nonatomic,copy) NSString* needClass;
/** 错误类型 */
@property (nonatomic,copy) NSString* errorClass;
/** 所在函数 */
@property (nonatomic,copy) NSString* inFunc;

- (instancetype)initWithCustomDescription:(NSString*)cDescription;
+ (instancetype)errorWithCustomDescription:(NSString*)cDescription;
- (NSString *)description;
- (NSString *)debugDescription;
- (instancetype)logError;
@end
