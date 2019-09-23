#import "AppDelegate+DDYNotification.h"
#import <objc/runtime.h>
#import <AudioToolbox/AudioToolbox.h>

@import UserNotifications;

@implementation AppDelegate (DDYNotification)

+ (void)load {
    // NSSelectorFromString(@"methodName") 或 @selector(methodName);
    // 交换启动方法
//    [self changeOrignalSEL:@selector(application:didFinishLaunchingWithOptions:)
//                swizzleSEL:@selector(ddy_NotificationApplication:didFinishLaunchingWithOptions:)];
}

+ (void)changeOrignalSEL:(SEL)orignalSEL swizzleSEL:(SEL)swizzleSEL {
    Method originalMethod = class_getInstanceMethod([self class], orignalSEL);
    Method swizzleMethod = class_getInstanceMethod([self class], swizzleSEL);
    if (class_addMethod([self class], orignalSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
        class_replaceMethod([self class], swizzleSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

- (BOOL)launchedByNotification {
    NSNumber *boolNum = objc_getAssociatedObject(self, @selector(launchedByNotification));
    return [boolNum boolValue];
}

- (void)setLaunchedByNotification:(BOOL)launchedByNotification {
    objc_setAssociatedObject(self, @selector(launchedByNotification), @(launchedByNotification), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 1.注册通知
#pragma mark 在程序启动后注册通知
- (BOOL)ddy_NotificationApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 程序是关闭(杀死)还是本身就是活跃(前台或挂起) 然后被通知打开
    NSDictionary *remoteNotification = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    self.launchedByNotification = (remoteNotification == nil ? NO : YES);
    // 远程通知
    [self registerRemoteNotification];
    // 本地通知
    [self registerLocalNotificationWithAlertTime:10];

    return YES;
//    return [self ddy_NotificationApplication:application didFinishLaunchingWithOptions:launchOptions];
}

#pragma mark 远程推送通知
- (void)registerRemoteNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *currentNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        currentNotificationCenter.delegate = self;
        UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [currentNotificationCenter requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error) [[UIApplication sharedApplication] registerForRemoteNotifications]; // 注册获得device Token
            });
        }];
    } else if (@available(iOS 8.0, *)) {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications]; // 注册获得device Token
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
#pragma clang diagnostic pop
    }
}

#pragma mark 本地通知 最多允许最近本地通知数量是64个，超过限制的被iOS忽略
- (void)registerLocalNotificationWithAlertTime:(NSInteger)alertTime {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *currentNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"本地通知" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:@"body:本地通知"  arguments:nil];
        content.sound = [UNNotificationSound defaultSound];
        // 在alertTime秒后推送本地推送
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:alertTime repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"  content:content trigger:trigger];
        // 添加推送成功后的处理！
        [currentNotificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        }];
    } else {
        // 查看iOS10一下通知请运行后马上按home键进后台
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        // 在alertTime秒后推送本地推送（如果要立即触发，无需设置）
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
        // 设置本地通知的时区
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复的间隔
        // localNotification.repeatInterval = kCFCalendarUnitSecond;
        // 通知重复提示的单位，可以是天、周、月
        // localNotification.repeatInterval = NSCalendarUnitDay;
        // 通知内容
        localNotification.alertBody =  @"本地通知";
        // 设置通知动作按钮的标题
        localNotification.alertAction = @"查看";
        // 角标数目
        localNotification.applicationIconBadgeNumber = 0;
        // 设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        //设置通知的相关参数信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
        NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:@"DDY",@"name",@"2018",@"time",@"1",@"aid",@"body:本地通知",@"key", nil];
        localNotification.userInfo = infoDic;
        // 将本地通知添加到调度池，定时发送
         [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        // 立即发送
        // [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    }
}

- (void)cancleLocalNotification {
    // 获取通知数组
    NSArray *notificaitons = [[UIApplication sharedApplication] scheduledLocalNotifications];
    // 无通知处理
    if (!notificaitons || notificaitons.count <= 0) {
        return;
    }
    // 取消一个特定的通知
    for (UILocalNotification *notify in notificaitons) {
        if ([[notify.userInfo objectForKey:@"name"] isEqualToString:@"DDY"]) {
            
            [[UIApplication sharedApplication] cancelLocalNotification:notify];
            break;
        }
    }
    // 取消所有的本地通知
    // [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma mark - 2.用户同意后，获取DeviceToken传给服务器保存
#pragma mark 此函数会在程序每次启动时调用(前提是用户允许通知)
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (token) NSLog(@"保存到本地并上传到服务器 token:%@",token);
    else NSLog(@"需要打开 target -> Capabilities —> Push Notifications 否则获取不到token");
}

#pragma mark 获取DeviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"DDYRegist Error: %@\n\n%@", error, error.code==3000 ? @"Open capabilities->Push Notification" : @" ");
}

#pragma mark - 3.收到推送消息后，进行相应的逻辑处理
#pragma mark iOS10+ 收到(本地和推送)通知 UNUserNotificationCenterDelegate App处于前台接收通知时触发，后台模式不走该方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)) {
    // 收到推送的请求
    UNNotificationRequest *request = notification.request;
    // 收到推送的内容
    UNNotificationContent *content = request.content;
    // 收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    // 收到推送消息的角标
    NSNumber *badge = content.badge;
    // 收到推送消息body
    NSString *body = content.body;
    // 推送消息的声音
    UNNotificationSound *sound = content.sound;
    // 推送消息的副标题
    NSString *subtitle = content.subtitle;
    // 推送消息的标题
    NSString *title = content.title;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@\n...省略一万行需求代码...",userInfo);
    }else {
        NSLog(@"iOS10 收到本地通知:{body:%@，title:%@,subtitle:%@,badge：%@，sound：%@，userInfo：%@}",body,title,subtitle,badge,sound,userInfo);
    }
    // 设置应用程序角标数
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

#pragma mark iOS10+ App通知的点击，点击，点击事件，如果使用长按（3DTouch）、Action等并不会触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)) {
    UNNotificationContent *content = response.notification.request.content;
    NSDictionary *userInfo = content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@\n...省略一万行需求代码...",userInfo);
    } else {
        NSLog(@"iOS10 收到本地通知:%@\n...省略一万行需求代码...",userInfo);
    }
    
    if (self.launchedByNotification) {
        NSLog(@"程序关闭(杀死)状态点击推送消息打开应用");
    } else {
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
             NSLog(@"程序前台运行");
        } else {
            NSLog(@"程序挂起但未被杀死");
        }
        // 收到推送消息手机震动，播放音效 AudioToolbox
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(1007);
    }
    // 设置应用程序角标数为0
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    /* 系统要求执行这个方法，否则提示 Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called. */
    completionHandler();
}

#pragma mark iOS6- 收到远程推送通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"iOS6及以下系统，收到通知:%@", userInfo);
}

#pragma mark iOS7-iOS10 收到远程推送通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"iOS7-iOS10系统，收到通知:%@", userInfo);
    if (self.launchedByNotification) {
        NSLog(@"程序关闭(杀死)状态点击推送消息打开应用");
    } else {
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            NSLog(@"程序前台运行");
        } else {
            NSLog(@"程序挂起但未被杀死");
        }
        // 收到推送消息手机震动，播放音效 AudioToolbox
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        AudioServicesPlaySystemSound(1007);
    }
    // 设置应用程序角标数为0
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification {
    NSLog(@"\n\
          1:应用程序在后台时，本地通知会给设备送达一个提醒，提醒样式由用户在手机设置中设置 \n\
          2.应用程序正在运行中，则设备不会收到提醒，但是会走应用程序delegate中的方法");
    if ([notification.userInfo[@"name"] isEqualToString:@"DDY"]) {
        // 如果是激活状态，则进行提醒，否则不提醒 (否则前后台可能重复)
        if (application.applicationState == UIApplicationStateActive) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:notification.alertBody delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:notification.alertAction, nil];
            [alert show];
        }
    }
}

@end

