#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (DDYExtension)

/** 沙盒document路径 [NSString documentPath] */
+ (NSString *)ddy_DocumentPath;
/** 沙盒cache路径 */
+ (NSString *)ddy_CachePath;
/** 沙盒library路径 */
+ (NSString *)ddy_LibraryPath;

/** bundleName (show in SpringBoard) */
+ (NSString *)ddy_AppBundleName;
/** bundleID com.**.app */
+ (NSString *)ddy_AppBundleID;
/** 版本号 1.1.1 */
+ (NSString *)ddy_AppVersion;
/** build 号 111 */
+ (NSString *)ddy_AppBuildNumber;

/** 过滤掉空格和某些特殊字符 */
+ (NSString *)ddy_TrimWhitespace:(nullable NSString *)string;

/** 判断是否为空 这里全空格也是空字符串 */
+ (BOOL)ddy_blankString:(nullable NSString *)string;

/** 时间date转字符串 */
+ (nullable NSString *)ddy_DateToString:(nullable NSDate *)date;

/** 数据data转字符串 */
+ (nullable NSString *)ddy_DataToString:(nullable NSData *)data;

/** 字符串转数据data */
- (nullable NSData *)ddy_StringToData;

/** Unicode字符串转常规字符串 */
- (nullable NSString *)ddy_UnicodeToString;

/** 汉字转拼音 */
- (nullable NSString *)ddy_ChangeToPinYin;

/** URL特殊符号编码 */
- (nullable NSString*)ddy_URLEncode;

/** 判断是否含有汉字 */
- (BOOL)ddy_IncludeChinese;

/** 判断是否是纯汉字 */
- (BOOL)ddy_OnlyChinese;

/** MD5 */
- (nullable NSString *)ddy_MD5;

/** SHA256加密 */
- (nullable NSString *)ddy_SHA256;

/** SHA256加密data */
+ (NSString *)ddy_SHA256WithData:(NSData *)data;

/** SHA265加密 后台对key加密 */
- (nullable NSString *)ddy_SHA256WithKey:(nonnull NSString *)key;

/** SHA3 Keccak-256加密 bitsLength:224/256/384/512 */
- (nullable NSString*)ddy_SHA3:(NSUInteger)bitsLength;

/** 是否只包含给定的字符串中的字符 例如@"0123456789" */
- (BOOL)ddy_OnlyHasCharacterOfString:(nullable NSString *)string;

/** 浮点数字符串合法性 */
- (BOOL)ddy_EffectFloatString;

/** 字典/数组转json字符串 */
+ (nullable NSString *)ddy_ArrayOrDictToJsonString:(id)obj;

/** json字符串转数组或者字典 */
- (nullable id)ddy_JsonStringToArrayOrDict;

/** json字符串转字典 */
- (NSDictionary *)ddy_JsonStringToDict;

/** json字符串转数组 */
- (NSArray *)ddy_JsonStringToArray;

/** 将16进制的字符串转换成NSData */
- (NSMutableData *)ddy_HexStrToData;

/** 计算文本size */
- (CGSize)sizeWithMaxWidth:(CGFloat)width font:(UIFont *)font;

@end
