#import "ViewController.h"
#import "DDYCategoryHeader.h"
#import "LinkBlock.h"
#import "DDYMacrol.h"
#import "DDYTestNavigationVC.h"

#ifndef DDYTopH
#define DDYTopH (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
#endif

#ifndef DDYScreenW
#define DDYScreenW [UIScreen mainScreen].bounds.size.width
#endif

#ifndef DDYScreenH
#define DDYScreenH [UIScreen mainScreen].bounds.size.height
#endif

@interface ViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIImage *img;

@property (nonatomic, strong) UIView *keyboardView;

@property (nonatomic, strong) UITextView *inputTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _img = [self circleImageWithColor:[UIColor ddy_ColorWithHexString:@"#00FFFF"] radius:10];
    [self btn:10  style:DDYBtnStyleImgLeft  padding:10 tag:101];
    [self btn:80  style:DDYBtnStyleImgRight padding:10 tag:102];
    [self btn:150 style:DDYBtnStyleImgTop   padding:10 tag:103];
    [self btn:220 style:DDYBtnStyleImgDown  padding:10 tag:104];
    [self btn:290 style:DDYBtnStyleNaturalImgRight  padding:10 tag:105];
    [self testLinkBlock];
    [self testTextView];
}

- (UIButton *)btn:(CGFloat)x style:(DDYBtnStyle)style padding:(CGFloat)padding tag:(NSUInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"title" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setImage:_img forState:UIControlStateNormal];
    [button ddy_SetStyle:style padding:padding];
    [button setFrame:CGRectMake(x, DDYTopH+10, 60, 60)];
    [button setIsShowHitTestLog:YES];
    [button setTag:tag];
    [button addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (void)testLinkBlock {
    UIViewNew.viewSetFrame(10, DDYTopH + 80, DDYScreenW-20, 30).viewBGColor([UIColor redColor]).viewAddToView(self.view);
}

- (UIView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = UIViewNew.viewSetFrame(10, DDYTopH+120, DDYScreenW-20, 24).viewBGColor([UIColor whiteColor]).viewAddToView(self.view);
        _keyboardView.layer.borderColor = [UIColor grayColor].CGColor;
        _keyboardView.layer.borderWidth = 1;
    }
    return _keyboardView;
}

- (UITextView *)inputTextView {
    if (!_inputTextView) {
        _inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 2, self.keyboardView.bounds.size.width-10, 20)];
        [_inputTextView setPlaceholder:@"限制字数参照 www.jianshu.com/p/7af65fcb9f87"];
        [_inputTextView setTextContainerInset:UIEdgeInsetsMake(2.5, 0, 2.5, 0)];
        [_inputTextView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_inputTextView setDelegate:self];
        [_inputTextView ddy_AutoHeightWithMinHeight:_inputTextView.bounds.size.height maxHeight:80];
        [_inputTextView ddy_AllowsNonContiguousLayout:NO];
        [_inputTextView ddy_KeyboardDismissModeOnDrag];
        [_inputTextView setShowsVerticalScrollIndicator:NO];
        [_inputTextView setShowsHorizontalScrollIndicator:NO];
        [_inputTextView setBounces:NO];
        [_inputTextView setBackgroundColor:[UIColor lightGrayColor]];
        [self.keyboardView addSubview:_inputTextView];
    }
    return _inputTextView;
}

- (void)testTextView {
    __weak __typeof (self)weakSelf = self;
    [self.inputTextView setAutoHeightBlock:^(CGFloat height) {
        __strong __typeof (weakSelf)strongSelf = weakSelf;
        strongSelf.keyboardView.ddy_h = height + 4;
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    
}

- (void)handleBtn:(UIButton *)sender {
    if (sender.tag == 101) {
        [UIAlertView ddy_AlertTitle:@"T" message:@"M" cancelTitle:@"0" otherTitle:@"1" clickIndexBlock:^(UIAlertView *alertView, NSInteger index) {
            NSLog(@"%d", (int)index);
        }];
    }
    if (sender.tag == 102) {
        [self ddy_navigationBarAlpha:0];
        DDYInfoLog(@"%d", (int)sender.tag);
    }
    if (sender.tag == 103) {
        [self ddy_navigationBarAlpha:0.5];
        [self ddy_bottomLineHidden:YES];
    }
    if (sender.tag == 104) {
        [self ddy_navigationBarAlpha:1];
        [self ddy_bottomLineHidden:NO];        
    }
    if(sender.tag == 105) {
        [self.navigationController pushViewController:[DDYTestNavigationVC new] animated:YES];
    }
    
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
