#import <Foundation/Foundation.h>

/** 排序规则 */
#ifndef DDYCollation
#define DDYCollation [UILocalizedIndexedCollation currentCollation]
#endif

@interface NSArray (DDYExtension)

/**
 模型数组索引排序
 @param selector 模型排序依据属性
 @return 排序后的数组
 */
- (NSMutableArray *)ddy_SortWithCollectionStringSelector:(SEL)selector;

/**
 模型数组索引标题
 @param model 模型类名
 @param selector 依据属性
 @param show 是否显示serach图标
 @return 索引标题数组
 */
- (NSMutableArray *)ddy_SortWithModel:(NSString *)model selector:(SEL)selector showSearch:(BOOL)show;

/**
 对模型数组进行索引排序(直接block回调排序后数组和标题数组)
 @param selector 模型排序依据属性
 @param complete 完成后回调(modelsArray:排序后模型数组，titlesArray：标题数组)

 */
- (void)ddy_ModelSortSelector:(SEL)selector complete:(void (^)(NSArray *modelsArray, NSArray *titlesArray))complete;


@end
