#import "AppDelegate.h"
#import "DDYCategoryHeader.h"
#import "ViewController.h"
#import "DDYSafeHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 安全守护，旨在预防
    [DDYSafeHeader ddy_SafeEffective];
    // 崩溃发生，防止闪退
    [DDYSafeHeader ddy_HandleUncaughtException];
    // 监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exceptionNotification:) name:DDYSafeNotification object:nil];
    
    // 打印控制器层级日志
    [UIViewController ddy_ShowPathLog:YES];
    // 注册通知
    [self ddy_NotificationApplication:application didFinishLaunchingWithOptions:launchOptions];
    // 3Dtouch快捷启动
    [self ddy_TouchApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [_window makeKeyAndVisible];
    return YES;
}

- (void)exceptionNotification:(NSNotification *)notification {
    NSLog(@"%@", notification.object);
}

@end
