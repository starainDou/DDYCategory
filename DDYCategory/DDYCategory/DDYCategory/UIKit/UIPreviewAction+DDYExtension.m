#import "UIPreviewAction+DDYExtension.h"
#import <objc/runtime.h>

@implementation UIPreviewAction (DDYExtension)

- (void)ddy_TinColor:(UIColor *)color {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIPreviewAction class], &count);
    for(int i = 0;i < count;i ++){
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        if ([ivarName isEqualToString:@"_color"] && color) {
            [self setValue:color forKey:@"color"];
        }
    }
    free(ivars);
}

@end
