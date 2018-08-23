#line 1 "/Users/soulghost/Desktop/git/UltimateSpringBoard/UltimateSpringBoard/UltimateSpringBoard.xmi"


#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "SBIconScrollView.h"
#import <QuartzCore/CATransform3D.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreMotion/CMMotionManager.h>
#include "USBMotionDetect.xm"
#import "USBDataManager.h"
#import "USBMotionManager.h"
#import "ARTrackManager.h"
#import "USBResource.h"


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBIconScrollView; 
static void (*_logos_orig$_ungrouped$SBIconScrollView$setPagingEnabled$)(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$SBIconScrollView$setPagingEnabled$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$_ungrouped$SBIconScrollView$handleUltimateBtnClick$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SBIconScrollView$enterUltimateMode(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBIconScrollView$quitUltimateMode(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBIconScrollView$resignBtnClick(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBIconScrollView$closeBtnClick(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static UIImage * _logos_method$_ungrouped$SBIconScrollView$captureScrollView$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL, UIScrollView *); static void _logos_method$_ungrouped$SBIconScrollView$addFakeScrollView(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBIconScrollView$logThings$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL, NSString *); static void _logos_method$_ungrouped$SBIconScrollView$startMotion(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBIconScrollView$stopMotion(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBIconScrollView$showToolbar(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBIconScrollView$hideToolbar(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); 

#line 15 "/Users/soulghost/Desktop/git/UltimateSpringBoard/UltimateSpringBoard/UltimateSpringBoard.xmi"


static char _logos_property_key$_ungrouped$SBIconScrollView$ultimateBtn;__attribute__((used)) static UIButton * _logos_method$_ungrouped$SBIconScrollView$ultimateBtn$(SBIconScrollView* __unused self, SEL __unused _cmd){ return objc_getAssociatedObject(self, &_logos_property_key$_ungrouped$SBIconScrollView$ultimateBtn); }__attribute__((used)) static void _logos_method$_ungrouped$SBIconScrollView$setUltimateBtn$(SBIconScrollView* __unused self, SEL __unused _cmd, UIButton * arg){ objc_setAssociatedObject(self, &_logos_property_key$_ungrouped$SBIconScrollView$ultimateBtn, arg, OBJC_ASSOCIATION_ASSIGN); }

static void _logos_method$_ungrouped$SBIconScrollView$setPagingEnabled$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL enabled) {
    static const void *key;
    if (objc_getAssociatedObject(self, key) != nil) {
        _logos_orig$_ungrouped$SBIconScrollView$setPagingEnabled$(self, _cmd, enabled);
        return;
    }
    objc_setAssociatedObject(self, key, @"", OBJC_ASSOCIATION_RETAIN);
    
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:NSClassFromString(@"SBHomeScreenWindow")]) {
            CGSize screenSize = [UIScreen mainScreen].bounds.size;
            CGFloat btnW = 60;
            CGFloat btnH = 60;
            CGFloat btnX = (screenSize.width - btnW) * 0.5f;
            CGFloat btnY = screenSize.height - 90 - btnH;
            
            UIButton *ultimateButton = [UIButton new];
            ultimateButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [ultimateButton setImage:[USBResource imageNamed:@"ultimate-normal.png"] forState:UIControlStateNormal];
            [ultimateButton setImage:[USBResource imageNamed:@"ultimate-highlight.png"] forState:UIControlStateHighlighted];
            [USBDataManager sharedInstance].ultimateBtn = ultimateButton;
            [ultimateButton addTarget:self action:@selector(handleUltimateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [window addSubview:ultimateButton];
            
            CGFloat toolbarBtnWH = 44;
            CGFloat marginH = 32;
            UIButton *resignBtn = [UIButton new];
            resignBtn.frame = CGRectMake(btnX - toolbarBtnWH - marginH, btnY, toolbarBtnWH, toolbarBtnWH);
            [resignBtn setImage:[USBResource imageNamed:@"resign.png"] forState:UIControlStateNormal];
            [USBDataManager sharedInstance].resignBtn = resignBtn;
            [resignBtn addTarget:self action:@selector(resignBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [window addSubview:resignBtn];
            
            UIButton *closeBtn = [UIButton new];
            closeBtn.frame = CGRectMake(btnX + btnW + marginH, btnY, toolbarBtnWH, toolbarBtnWH);
            [closeBtn setImage:[USBResource imageNamed:@"close.png"] forState:UIControlStateNormal];
            [USBDataManager sharedInstance].closeBtn = closeBtn;
            [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [window addSubview:closeBtn];
            
            resignBtn.hidden = 1;
            closeBtn.hidden = 1;
            break;
        }
    }
    _logos_orig$_ungrouped$SBIconScrollView$setPagingEnabled$(self, _cmd, enabled);
}


static void _logos_method$_ungrouped$SBIconScrollView$handleUltimateBtnClick$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id sender) {
    UIButton *btn = sender;
    if (btn.selected) {
        [self performSelector:@selector(quitUltimateMode)];
    } else {
        [self performSelector:@selector(enterUltimateMode)];
    }
    btn.selected = !btn.selected;
}


static void _logos_method$_ungrouped$SBIconScrollView$enterUltimateMode(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    [self performSelector:@selector(startMotion)];
}


static void _logos_method$_ungrouped$SBIconScrollView$quitUltimateMode(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    [self performSelector:@selector(stopMotion)];
    
    CGFloat offsetX = [USBDataManager sharedInstance].fakeScrollView.contentOffset.x;
    int pageNum = offsetX * 1.1f / self.frame.size.width;
    offsetX = self.frame.size.width * pageNum;
    self.contentOffset = CGPointMake(offsetX, 0);

    self.hidden = 0;
    [[USBDataManager sharedInstance].fakeScrollView removeFromSuperview];
}


static void _logos_method$_ungrouped$SBIconScrollView$resignBtnClick(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    [[ARTrackManager sharedManager] rebase];
}


static void _logos_method$_ungrouped$SBIconScrollView$closeBtnClick(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    exit(0);
}


static UIImage * _logos_method$_ungrouped$SBIconScrollView$captureScrollView$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIScrollView * scrollView) {
    if ([USBDataManager sharedInstance].snapshot) {
        return [USBDataManager sharedInstance].snapshot;
    }
    CGRect rect = (CGRect){0, 0, scrollView.contentSize};
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    [UIImagePNGRepresentation(snapshot) writeToFile: @"/tmp/springboard.png" atomically:YES];
    UIGraphicsEndImageContext();
    [USBDataManager sharedInstance].snapshot = snapshot;
    return snapshot;
}


static void _logos_method$_ungrouped$SBIconScrollView$addFakeScrollView(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:NSClassFromString(@"SBHomeScreenWindow")]) {
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [USBDataManager sharedInstance].fakeScrollView = scrollView;
            scrollView.alpha = 0.6f;
            UIImage *image = [self performSelector:@selector(captureScrollView:) withObject:self];
            scrollView.contentSize = image.size;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = (CGRect){0, 0, image.size};
            [scrollView addSubview:imageView];
            [window insertSubview:scrollView belowSubview:[USBDataManager sharedInstance].ultimateBtn];
            imageView.layer.transform = CATransform3DScale(imageView.layer.transform, 0.9f, 0.9f, 1.0f);
            
            CALayer *layer = scrollView.layer;
            CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
            rotationAndPerspectiveTransform.m34 = 1.0 / -500;
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 10 * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
            layer.transform = rotationAndPerspectiveTransform;
        }
    }
}


static void _logos_method$_ungrouped$SBIconScrollView$logThings$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * thing) {
    [[[UIAlertView alloc] initWithTitle:thing message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}


static void _logos_method$_ungrouped$SBIconScrollView$startMotion(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    __block bool hasShowReady = 0;
    [[ARTrackManager sharedManager] startTracking];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 1.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [[USBDataManager sharedInstance].ultimateBtn.layer addAnimation:rotationAnimation forKey:@"rotate"];
    float initX = self.contentOffset.x - self.frame.size.width;
    if (initX < 0) {
        initX = 0;
    }
    [[ARTrackManager sharedManager].callbacks addObject:^(float dx, float dy, float dz) {
        int offsetX = dx * 3500 + initX;

        dispatch_async(dispatch_get_main_queue(), ^{
            if (!hasShowReady) {
                hasShowReady = 1;
                [self performSelector:@selector(showToolbar)];
                [self performSelector:@selector(addFakeScrollView)];
                self.hidden = 1;
                return;
            }
            CGPoint cf = [USBDataManager sharedInstance].fakeScrollView.contentOffset;
            cf.x = offsetX + self.frame.size.width;
            if (cf.x < self.frame.size.width) {
                cf.x = self.frame.size.width;
            } else if (cf.x > [USBDataManager sharedInstance].fakeScrollView.contentSize.width - self.frame.size.width) {
                cf.x = [USBDataManager sharedInstance].fakeScrollView.contentSize.width - self.frame.size.width;
            }
            [USBDataManager sharedInstance].fakeScrollView.contentOffset = cf;
        });
    }];
}


static void _logos_method$_ungrouped$SBIconScrollView$stopMotion(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    [[ARTrackManager sharedManager] stopTracking];
    [self performSelector:@selector(hideToolbar)];
}


static void _logos_method$_ungrouped$SBIconScrollView$showToolbar(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    UIButton *ultimateBtn = [USBDataManager sharedInstance].ultimateBtn;
    [ultimateBtn.layer removeAnimationForKey:@"rotate"];
    [UIView animateWithDuration:0.5 animations:^{
        ultimateBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -50);
    }];
    [USBDataManager sharedInstance].resignBtn.hidden = 0;
    [USBDataManager sharedInstance].closeBtn.hidden = 0;
}


static void _logos_method$_ungrouped$SBIconScrollView$hideToolbar(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    UIButton *ultimateBtn = [USBDataManager sharedInstance].ultimateBtn;
    [UIView animateWithDuration:0.5 animations:^{
        ultimateBtn.transform = CGAffineTransformIdentity;
    }];
    [USBDataManager sharedInstance].resignBtn.hidden = 1;
    [USBDataManager sharedInstance].closeBtn.hidden = 1;
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBIconScrollView = objc_getClass("SBIconScrollView"); MSHookMessageEx(_logos_class$_ungrouped$SBIconScrollView, @selector(setPagingEnabled:), (IMP)&_logos_method$_ungrouped$SBIconScrollView$setPagingEnabled$, (IMP*)&_logos_orig$_ungrouped$SBIconScrollView$setPagingEnabled$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(handleUltimateBtnClick:), (IMP)&_logos_method$_ungrouped$SBIconScrollView$handleUltimateBtnClick$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(enterUltimateMode), (IMP)&_logos_method$_ungrouped$SBIconScrollView$enterUltimateMode, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(quitUltimateMode), (IMP)&_logos_method$_ungrouped$SBIconScrollView$quitUltimateMode, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(resignBtnClick), (IMP)&_logos_method$_ungrouped$SBIconScrollView$resignBtnClick, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(closeBtnClick), (IMP)&_logos_method$_ungrouped$SBIconScrollView$closeBtnClick, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIScrollView *), strlen(@encode(UIScrollView *))); i += strlen(@encode(UIScrollView *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(captureScrollView:), (IMP)&_logos_method$_ungrouped$SBIconScrollView$captureScrollView$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(addFakeScrollView), (IMP)&_logos_method$_ungrouped$SBIconScrollView$addFakeScrollView, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(logThings:), (IMP)&_logos_method$_ungrouped$SBIconScrollView$logThings$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(startMotion), (IMP)&_logos_method$_ungrouped$SBIconScrollView$startMotion, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(stopMotion), (IMP)&_logos_method$_ungrouped$SBIconScrollView$stopMotion, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(showToolbar), (IMP)&_logos_method$_ungrouped$SBIconScrollView$showToolbar, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(hideToolbar), (IMP)&_logos_method$_ungrouped$SBIconScrollView$hideToolbar, _typeEncoding); }{ class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(ultimateBtn), (IMP)&_logos_method$_ungrouped$SBIconScrollView$ultimateBtn$, [[NSString stringWithFormat:@"%s@:", @encode(UIButton *)] UTF8String]);class_addMethod(_logos_class$_ungrouped$SBIconScrollView, @selector(setUltimateBtn:), (IMP)&_logos_method$_ungrouped$SBIconScrollView$setUltimateBtn$, [[NSString stringWithFormat:@"v@:%s", @encode(UIButton *)] UTF8String]);} } }
#line 217 "/Users/soulghost/Desktop/git/UltimateSpringBoard/UltimateSpringBoard/UltimateSpringBoard.xmi"
