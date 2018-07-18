


#import "LinkBlockDefine.h"

#ifndef UIWebViewNew
#define UIWebViewNew ([UIWebView new])
#endif
@class JSContext;
@interface NSObject(UIWebViewLinkBlock)
/** <^()> */
LBDeclare JSContext*      (^webViewContext)();
/** <^(NSString* script)> */
LBDeclare NSString*       (^webViewEvalScript)(NSString* script);
/** <^()> */
LBDeclare NSString*       (^webViewTitle)();
/** <^()> */
LBDeclare NSString*       (^webViewLocationHref)();
/** <^()> */
LBDeclare NSString*       (^webViewHTML)();
@end
