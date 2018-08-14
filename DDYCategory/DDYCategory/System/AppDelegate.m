#import "AppDelegate.h"
#import "DDYCategoryHeader.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 测试打印控制器层级日志
    [UIViewController ddy_ShowPathLog:YES];
    // 测试注册通知
    [self ddy_NotificationApplication:application didFinishLaunchingWithOptions:launchOptions];
    // 测试3Dtouch快捷启动
    [self ddy_TouchApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [_window makeKeyAndVisible];
    return YES;
}

@end
