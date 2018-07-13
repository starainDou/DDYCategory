#import "ViewController.h"
#import "DDYCategoryHeader.h"
#import <objc/runtime.h>

#ifndef DDYTopH
#define DDYTopH (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
#endif

#ifndef DDYScreenW
#define DDYScreenW [UIScreen mainScreen].bounds.size.width
#endif

#ifndef DDYScreenH
#define DDYScreenH [UIScreen mainScreen].bounds.size.height
#endif

@interface ViewController ()

@property (nonatomic, strong) UIImage *img;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _img = [self circleImageWithColor:[UIColor ddy_ColorWithHexString:@"#00FFFF"] radius:10];
    
    [self btn:10  style:DDYBtnStyleImgLeft  padding:10];
    [self btn:80  style:DDYBtnStyleImgRight padding:10];
    [self btn:150 style:DDYBtnStyleImgTop   padding:10];
    [self btn:220 style:DDYBtnStyleImgDown  padding:10];
    
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        if ([objcName isEqualToString:@"_placeholderLabel"]) {
            NSLog(@"%d : %@",i,objcName);
        }
    }
}

- (UIButton *)btn:(CGFloat)x style:(DDYBtnStyle)style padding:(CGFloat)padding {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"title" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setImage:_img forState:UIControlStateNormal];
    [button ddy_SetStyle:style padding:padding];
    [button setFrame:CGRectMake(x, DDYTopH+10, 60, 60)];
    [button setIsShowHitTestLog:YES];
    [button addTarget:self action:@selector(handleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (void)handleBtn {
    UIAlertView *alertView = [UIAlertView ddy_AlertTitle:@"0" message:@"1" cancelTitle:@"Cancel" otherTitle:@"OK" clickIndex:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
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

@end

/** 如果遇到方法不对或不好请告诉我 634778311 小菜一个 正在努力学习各种知识中 */
