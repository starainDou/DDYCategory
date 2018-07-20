#import "ViewController.h"
#import "DDYCategoryHeader.h"
#import "LinkBlock.h"
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
    
    [self testLinkBlock];
    [self testTextView];
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

- (void)testLinkBlock {
    UIViewNew.viewSetFrame(10, DDYTopH + 80, DDYScreenW-20, 30).viewBGColor([UIColor redColor]).viewAddToView(self.view);
}

- (void)testTextView {
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, DDYTopH+120, DDYScreenW-20, 100)];
    textView.placeholder = @"大哥，我是来占位！！！";
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.layer.borderColor = [UIColor blackColor].CGColor;
    textView.layer.borderWidth = 1;
    [self.view addSubview:textView];
}

- (void)handleBtn {
    [UIAlertView ddy_AlertTitle:@"0"
                        message:@"1"
                    cancelTitle:@"Cancel"
                     otherTitle:@"OK"
                clickIndexBlock:^(UIAlertView *alertView, NSInteger index) {
                    NSLog(@"%d", (int)index);
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
