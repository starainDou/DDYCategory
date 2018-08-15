#import "NSString+DDYSafe.h"
#import "DDYSafeHeader.h"

@implementation NSString (DDYSafe)

#pragma mark 执行一次方法交换 开启安全处理 防止常见崩溃
+ (void)ddy_SafeEffect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class _NSCFConstantString = NSClassFromString(@"__NSCFConstantString");
        Class _NSTaggedPointerString = NSClassFromString(@"NSTaggedPointerString");
        [_NSCFConstantString ddy_SwapMethod:@selector(characterAtIndex:)
                                 swizzleSel:@selector(ddy_CharacterAtIndex:)];
        [_NSCFConstantString ddy_SwapMethod:@selector(substringFromIndex:)
                                 swizzleSel:@selector(ddy_SubstringFromIndex:)];
        [_NSCFConstantString ddy_SwapMethod:@selector(substringToIndex:)
                                 swizzleSel:@selector(ddy_SubstringToIndex:)];
        [_NSCFConstantString ddy_SwapMethod:@selector(substringWithRange:)
                                 swizzleSel:@selector(ddy_SubstringWithRange:)];
        [_NSCFConstantString ddy_SwapMethod:@selector(stringByReplacingOccurrencesOfString:withString:)
                                 swizzleSel:@selector(ddy_StringByReplacingOccurrencesOfString:withString:)];
        [_NSCFConstantString ddy_SwapMethod:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                                 swizzleSel:@selector(ddy_StringByReplacingOccurrencesOfString:withString:options:range:)];
        [_NSCFConstantString ddy_SwapMethod:@selector(stringByReplacingCharactersInRange:withString:)
                                 swizzleSel:@selector(ddy_StringByReplacingCharactersInRange:withString:)];
        
        [_NSTaggedPointerString ddy_SwapMethod:@selector(characterAtIndex:)
                                    swizzleSel:@selector(ddy_TaggetPointerCharacterAtIndex:)];
        [_NSTaggedPointerString ddy_SwapMethod:@selector(substringFromIndex:)
                                    swizzleSel:@selector(ddy_TaggetPointerSubstringFromIndex:)];
        [_NSTaggedPointerString ddy_SwapMethod:@selector(substringToIndex:)
                                    swizzleSel:@selector(ddy_TaggetPointerSubstringToIndex:)];
        [_NSTaggedPointerString ddy_SwapMethod:@selector(substringWithRange:)
                                    swizzleSel:@selector(ddy_TaggetPointerSubstringWithRange:)];
        [_NSTaggedPointerString ddy_SwapMethod:@selector(stringByReplacingOccurrencesOfString:withString:)
                                    swizzleSel:@selector(ddy_TaggetPointerStringByReplacingOccurrencesOfString:withString:)];
        [_NSTaggedPointerString ddy_SwapMethod:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                                    swizzleSel:@selector(ddy_TaggetPointerStringByReplacingOccurrencesOfString:withString:options:range:)];
        [_NSTaggedPointerString ddy_SwapMethod:@selector(stringByReplacingCharactersInRange:withString:)
                                    swizzleSel:@selector(ddy_TaggetPointerStringByReplacingCharactersInRange:withString:)];
    });
}

- (unichar)ddy_CharacterAtIndex:(NSUInteger)index {
    unichar character;
    @try {
        character = [self ddy_CharacterAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *solution = @"DDYSafe return unsigned short to avoid crash";
        [self ddy_HandleException:exception defaultSolution:solution];
    }
    @finally {
        return character;
    }
}

- (NSString *)ddy_SubstringFromIndex:(NSUInteger)from {
    NSString *subString = nil;
    @try {
        subString = [self ddy_SubstringFromIndex:from];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return subString;
    }
}

- (NSString *)ddy_SubstringToIndex:(NSUInteger)to {
    NSString *subString = nil;
    @try {
        subString = [self ddy_SubstringToIndex:to];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return subString;
    }
}

- (NSString *)ddy_SubstringWithRange:(NSRange)range {
    NSString *subString = nil;
    @try {
        subString = [self ddy_SubstringWithRange:range];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return subString;
    }
}

- (NSString *)ddy_StringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    NSString *newString = self;
    @try {
        newString = [self ddy_StringByReplacingOccurrencesOfString:target withString:replacement];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        return newString;
    }
}

- (NSString *)ddy_StringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    NSString *newString = self;
    @try {
        newString = [self ddy_StringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        return newString;
    }
}

- (NSString *)ddy_StringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    NSString *newString = self;
    @try {
        newString = [self ddy_StringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        return newString;
    }
}

- (unichar)ddy_TaggetPointerCharacterAtIndex:(NSUInteger)index {
    unichar character;
    @try {
        character = [self ddy_TaggetPointerCharacterAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *solution = @"DDYSafe return unsigned short to avoid crash";
        [self ddy_HandleException:exception defaultSolution:solution];
    }
    @finally {
        return character;
    }
}

- (NSString *)ddy_TaggetPointerSubstringFromIndex:(NSUInteger)from {
    NSString *subString = nil;
    @try {
        subString = [self ddy_TaggetPointerSubstringFromIndex:from];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return subString;
    }
}

- (NSString *)ddy_TaggetPointerSubstringToIndex:(NSUInteger)to {
    NSString *subString = nil;
    @try {
        subString = [self ddy_TaggetPointerSubstringToIndex:to];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return subString;
    }
}

- (NSString *)ddy_TaggetPointerSubstringWithRange:(NSRange)range {
    NSString *subString = nil;
    @try {
        subString = [self ddy_TaggetPointerSubstringWithRange:range];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeReturnNil];
    }
    @finally {
        return subString;
    }
}

- (NSString *)ddy_TaggetPointerStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    NSString *newString = self;
    @try {
        newString = [self ddy_TaggetPointerStringByReplacingOccurrencesOfString:target withString:replacement];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        return newString;
    }
}

- (NSString *)ddy_TaggetPointerStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    NSString *newString = self;
    @try {
        newString = [self ddy_TaggetPointerStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        return newString;
    }
}

- (NSString *)ddy_TaggetPointerStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    NSString *newString = self;
    @try {
        newString = [self ddy_TaggetPointerStringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        [self ddy_HandleException:exception defaultSolution:DDYSafeIgnore];
    }
    @finally {
        return newString;
    }
}

@end

/**
 ???: 什么时候出现不同类型？
 当字符长度小于等于9,会转换为NSTaggedPointerString,具体可了解taggedPointer http://www.cocoachina.com/ios/20150918/13449.html
 */
