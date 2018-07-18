


#import "LinkInfo.h"

typedef enum LinkReturnType{
    LinkReturnLink,//链条返回
    LinkReturnCondition,//条件中断...linkIf...linkElse...
}LinkReturnType;
@interface LinkReturn : LinkInfo
@property (nonatomic,strong) id returnValue;
@property (nonatomic,assign) LinkReturnType returnType;
- (instancetype)initWithReturnValue:(id)returnValue;
- (instancetype)initWithReturnValue:(id)returnValue returnType:(LinkReturnType)returnType;
@end
