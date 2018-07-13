#import "AppDelegate.h"

@import UserNotifications;

@interface AppDelegate (DDYNotification)<UNUserNotificationCenterDelegate>

@property (nonatomic) BOOL launchedByNotification;

@end
/** 打开交换方法(+load自动执行)，引入头文件(方法/属性生效) */
