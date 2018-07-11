#import "ViewController.h"
#import "DDYAuthorityManager.h"

@interface ViewController ()

@property (nonatomic, strong) UIImage *imgNormal;

@property (nonatomic, strong) UIImage *imgSelect;

@property (nonatomic, strong) NSMutableArray *buttonArray;
// CLLocationManager实例必须是全局的变量，否则授权提示弹框可能不会一直显示。
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgNormal = [self circleBorderWithColor:[UIColor grayColor] radius:8];
    _imgSelect = [self circleImageWithColor:[UIColor greenColor] radius:8];
    
    [self requestWhenInUseLocationAuthorization];
    [self registerRemoteNotification];
    
    NSArray *authArray = @[@"麦克风", @"摄像头", @"相册", @"通讯录", @"日历", @"备忘录", @"联网权限", @"推送", @"定位", @"语音识别", @"特别声明"];
    for (NSInteger i = 0; i < authArray.count; i++) {
        @autoreleasepool {
            UIButton *button = [self generateButton:i title:authArray[i]];
            [self.buttonArray addObject:button];
            if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%ld_auth", button.tag]]) {
                [self performSelectorOnMainThread:@selector(handleClick:) withObject:button waitUntilDone:YES];
            }
        }
    }
}

#pragma mark 定位申请
- (void)requestWhenInUseLocationAuthorization {
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager requestWhenInUseAuthorization];
    }
}

#pragma mark 远程推送通知 实际要在Appdelegate（可使用分类）
- (void)registerRemoteNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *currentNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
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

- (UIButton *)generateButton:(NSInteger)tag title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [button setImage:_imgNormal forState:UIControlStateNormal];
    [button setImage:_imgSelect forState:UIControlStateSelected];
    [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTag:tag+100];
    [self.view addSubview:button];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setFrame:CGRectMake(self.view.bounds.size.width/2.-60, tag*45 + 100, 120, 30)];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor redColor].CGColor;
    return button;
}

- (void)handleClick:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:[NSString stringWithFormat:@"%ld_auth", sender.tag]];
    if (sender.tag == 100) {
        [DDYAuthorityManager ddy_AudioAuthAlertShow:YES success:^{
            sender.selected = YES;
        } fail:^(AVAuthorizationStatus authStatus) { }];
    } else if (sender.tag == 101) {
        if ([DDYAuthorityManager isCameraAvailable]) {
            [DDYAuthorityManager ddy_CameraAuthAlertShow:YES success:^{
                sender.selected = YES;
            } fail:^(AVAuthorizationStatus authStatus) { }];
        } else {
            sender.selected = NO;
            NSLog(@"摄像头不可用");
        }
    } else if (sender.tag == 102) {
        [DDYAuthorityManager ddy_AlbumAuthAlertShow:YES success:^{
            sender.selected = YES;
        } fail:^(PHAuthorizationStatus authStatus) { }];
    } else if (sender.tag == 103) {
        [DDYAuthorityManager ddy_ContactsAuthAlertShow:YES success:^{
            sender.selected = YES;
        } fail:^(DDYContactsAuthStatus authStatus) { }];
    } else if (sender.tag == 104) {
        [DDYAuthorityManager ddy_EventAuthAlertShow:YES success:^{
            sender.selected = YES;
        } fail:^(EKAuthorizationStatus authStatus) { }];
    } else if (sender.tag == 105) {
        [DDYAuthorityManager ddy_ReminderAuthAlertShow:YES success:^{
            sender.selected = YES;
        } fail:^(EKAuthorizationStatus authStatus) { }];
    } else if (sender.tag == 106) {
        if (@available(iOS 10.0, *)) {
            [DDYAuthorityManager ddy_NetAuthAlertShow:YES success:^{
                sender.selected = YES;
            } fail:^(CTCellularDataRestrictedState authStatus) { }];
        } else {
            sender.selected = YES;
        }
    } else if (sender.tag == 107) {
        [DDYAuthorityManager ddy_PushNotificationAuthAlertShow:YES success:^{
            sender.selected = YES;
        } fail:^{ }];
    } else if (sender.tag == 108) {
        if ([CLLocationManager locationServicesEnabled]) {
            [DDYAuthorityManager ddy_LocationAuthType:DDYCLLocationTypeInUse alertShow:YES success:^{
                sender.selected = YES;
            } fail:^(CLAuthorizationStatus authStatus) { }];
        } else {
            sender.selected = NO;
            NSLog(@"定位服务未开启");
        }
        
    } else if (sender.tag == 109) {
        if (@available(iOS 10.0, *)) {
            [DDYAuthorityManager ddy_SpeechAuthAlertShow:YES success:^{
                sender.selected = YES;
            } fail:^(SFSpeechRecognizerAuthorizationStatus authStatus) { }]; 
        } else {
            sender.selected = NO;
            [self showAlertWithMessage:@"iOS10+才有"];
        }
    } else {
        NSLog(@"Demo仅供参考");
    }
}

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark 绘制圆形图片
- (UIImage *)circleImageWithColor:(UIColor *)color radius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, radius*2.0, radius*2.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillEllipseInRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark 绘制圆形框
- (UIImage *)circleBorderWithColor:(UIColor *)color radius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, radius*2.0, radius*2.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, radius, radius, radius-1, 0, 2*M_PI, 0);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
