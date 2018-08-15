#import "NSMutableString+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation NSMutableString (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class _NSCFString = NSClassFromString(@"__NSCFString");
        // MARK: replaceCharactersInRange:withString:
        [_NSCFString ddy_SwapMethod:@selector(replaceCharactersInRange:withString:) swizzleSel:@selector(ddy_ReplaceCharactersInRange:withString:)];
        // MARK: insertString:atIndex:
        [_NSCFString ddy_SwapMethod:@selector(insertString:atIndex:) swizzleSel:@selector(ddy_InsertString:atIndex:)];
        // MARK: deleteCharactersInRange:
        [_NSCFString ddy_SwapMethod:@selector(deleteCharactersInRange:) swizzleSel:@selector(ddy_DeleteCharactersInRange:)];
    });
}

- (void)ddy_ReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    @try {
        [self ddy_ReplaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

- (void)ddy_InsertString:(NSString *)aString atIndex:(NSUInteger)loc {
    @try {
        [self ddy_InsertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

- (void)ddy_DeleteCharactersInRange:(NSRange)range {
    @try {
        [self ddy_DeleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        
    }
}

@end
