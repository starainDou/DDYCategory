#import "AppDelegate.h"

@import UserNotifications;

@interface AppDelegate (DDYNotification)<UNUserNotificationCenterDelegate>

@property (nonatomic) BOOL launchedByNotification;

@end
