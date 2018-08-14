#import "AppDelegate+DDY3DTouch.h"

@implementation AppDelegate (DDY3DTouch)

#pragma mark 在程序启动后注册3DTouch
- (BOOL)ddy_TouchApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 9.0, *)) {
        if ([UIScreen mainScreen].traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self creatShortcutItem];
            UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
            /** app已杀死处理逻辑,不调用 -application:performActionForShortcutItem:completionHandler: */
            if (shortcutItem) {
                if([shortcutItem.type isEqualToString:@"open_search"]){
                    NSLog(@"open_search");
                } else if ([shortcutItem.type isEqualToString:@"open_qrcode"]) {
                    NSLog(@"open_qrcode");
                }
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark - 3D Touch
#pragma mark 创建3DTouch列表
- (void)creatShortcutItem API_AVAILABLE(ios(9.0)) {
    // 创建系统风格的icon
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"open_search" localizedTitle:@"分享" localizedSubtitle:@"分享副标题" icon:icon1 userInfo:nil];
    // 创建自定义图标的icon
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"qrcode"];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"open_qrcode" localizedTitle:@"扫描" localizedSubtitle:@"扫描副标题" icon:icon2 userInfo:nil];
    // 添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item1, item2];
}

#pragma mark 修改3DTouch列表标签
- (void)editShortcutItem API_AVAILABLE(ios(9.0)) {
    // 获取第0个shortcutItem
    UIApplicationShortcutItem *shortcutItem = [[UIApplication sharedApplication].shortcutItems objectAtIndex:0];
    // 将shortcutItem0的类型由UIApplicationShortcutItem改为可修改类型UIMutableApplicationShortcutItem
    UIMutableApplicationShortcutItem *item = [shortcutItem mutableCopy];
    // 修改shortcutItem的标题
    [item setLocalizedTitle:@"修改"];
    [item setLocalizedSubtitle:@"修改副标题"];
    [item setIcon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd]];
    // 将shortcutItems数组改为可变数组
    NSMutableArray *itemArray = [[UIApplication sharedApplication].shortcutItems mutableCopy];
    // 替换原ShortcutItem
    [itemArray replaceObjectAtIndex:0 withObject:item];
    [UIApplication sharedApplication].shortcutItems = itemArray;
}

#pragma mark 后台状态点击3DTouch选项进入APP
/** app不在后台(已杀死)，则处理逻辑在 -application:didFinishLaunchingWithOptions:中 */
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler API_AVAILABLE(ios(9.0)) {
    
    if (shortcutItem) {
        if([shortcutItem.type isEqualToString:@"open_search"]){
            NSLog(@"open_search");
        } else if ([shortcutItem.type isEqualToString:@"open_qrcode"]) {
            NSLog(@"open_qrcode");
            [self editShortcutItem];
        }
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
}

@end
