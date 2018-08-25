// See http://iphonedevwiki.net/index.php/Logos

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "SBIconScrollView.h"
#import <QuartzCore/CATransform3D.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreMotion/CMMotionManager.h>
#import "USBDataManager.h"
#import "USBMotionManager.h"
#import "ARTrackManager.h"
#import "USBResource.h"

%hook SpringBoard

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if ([USBDataManager sharedInstance].fakeScrollView) {
        UIScrollView *scrollView = [USBDataManager sharedInstance].fakeScrollView;
        if ([scrollView isKindOfClass:[UIScrollView class]]) {
            [USBDataManager sharedInstance].desktopScrollView.hidden = NO;
            [scrollView removeFromSuperview];
        }
    }
}

%new
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        exit(0);
    }
}

%end

%hook SBIconScrollView

%property (nonatomic) UIButton *ultimateBtn;

- (void)setPagingEnabled:(BOOL)enabled {
    static const void *key;
    if (objc_getAssociatedObject(self, key) != nil) {
        %orig(enabled);
        return;
    }
    objc_setAssociatedObject(self, key, @"", OBJC_ASSOCIATION_RETAIN);
    [USBDataManager sharedInstance].desktopScrollView = self;
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:NSClassFromString(@"SBHomeScreenWindow")]) {
            [USBDataManager sharedInstance].window = window;
            [USBDataManager sharedInstance].vc = window.rootViewController;
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
    %orig(enabled);
}

%new
- (void)handleUltimateBtnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.selected) {
        [self performSelector:@selector(quitUltimateMode)];
    } else {
        [self performSelector:@selector(enterUltimateMode)];
    }
    btn.selected = !btn.selected;
}

%new
- (void)enterUltimateMode {
    [self performSelector:@selector(startMotion)];
}

%new
- (void)quitUltimateMode {
    [self performSelector:@selector(stopMotion)];
    // modify
    CGFloat offsetX = [USBDataManager sharedInstance].fakeScrollView.contentOffset.x;
    int pageNum = offsetX * 1.1f / self.frame.size.width;
    offsetX = self.frame.size.width * pageNum;
    self.contentOffset = CGPointMake(offsetX, 0);
//    [@(offsetX).description writeToFile:@"/tmp/tick.txt" atomically:1 encoding:4 error:nil];
    self.hidden = 0;
    [[USBDataManager sharedInstance].fakeScrollView removeFromSuperview];
}

%new
- (void)resignBtnClick {
    [[ARTrackManager sharedManager] rebase];
}

%new
- (void)closeBtnClick {
    exit(0);
}

%new
- (UIImage *)captureScrollView:(UIScrollView *)scrollView {
    if ([USBDataManager sharedInstance].snapshot) {
        return [USBDataManager sharedInstance].snapshot;
    }
    CGRect rect = (CGRect){0, 0, scrollView.contentSize};
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *middleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *topImage = [USBResource imageNamed:@"camera.png"];
    UIImage *bottomImage = [USBResource imageNamed:@"earth.png"];
    CGFloat imageMargin = 320;
    CGFloat marginH = 80;
    CGFloat topImageW = 120;
    CGFloat topImageH = 89;
    CGFloat bottomImageW = 120;
    CGFloat bottomImageH = 120;
    CGSize ctxSize = CGSizeMake(middleImage.size.width, middleImage.size.height + topImageH + bottomImageH + imageMargin * 4);
    UIGraphicsBeginImageContextWithOptions(ctxSize, NO, [UIScreen mainScreen].scale);
    // add top image: camera
    CGFloat topImageX = marginH;
    CGFloat topImageY = topImageH + imageMargin;
    NSInteger count = (ctxSize.width - marginH) / (topImageW + marginH);
    for (NSInteger i = 0; i < count; i++) {
        [topImage drawInRect:CGRectMake(topImageX, topImageY, topImageW, topImageH)];
        topImageX += topImageW + marginH;
    }
    // add middle image: desktop
    [middleImage drawInRect:CGRectMake(0, topImageH + imageMargin * 2, middleImage.size.width, middleImage.size.height)];
    // add bottom image: earth
    CGFloat bottomImageX = marginH;
    CGFloat bottomImageY = ctxSize.height - imageMargin - bottomImageH;
    count = (ctxSize.width - marginH) / (bottomImageW + marginH);
    for (NSInteger i = 0; i < count; i++) {
        [bottomImage drawInRect:CGRectMake(bottomImageX, bottomImageY, bottomImageW, bottomImageH)];
        bottomImageX += bottomImageW + marginH;
    }
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [USBDataManager sharedInstance].snapshot = snapshot;
    //    [UIImagePNGRepresentation(snapshot) writeToFile: @"/tmp/springboard.png" atomically:YES];
    return snapshot;
}

%new
- (void)addFakeScrollView {
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
            // 3D
            CALayer *layer = scrollView.layer;
            CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
            rotationAndPerspectiveTransform.m34 = 1.0 / -500;
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 10 * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
            layer.transform = rotationAndPerspectiveTransform;
        }
    }
}

%new
- (void)logThings:(NSString *)thing {
    [[[UIAlertView alloc] initWithTitle:thing message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

%new
- (void)startMotion {
    __block bool hasShowReady = 0;
    [[ARTrackManager sharedManager] startTracking];
    [USBDataManager sharedInstance].resignBtn.hidden = 0;
    [USBDataManager sharedInstance].closeBtn.hidden = 0;
    // start rotate
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
    float initY = 1200;
    [[ARTrackManager sharedManager].callbacks addObject:^(float dx, float dy, float dz) {
        int offsetX = dx * 3500 + initX;
        int offsetY = -dy * 3500 + initY;
        [@(offsetY).description writeToFile:@"/tmp/tick.txt" atomically:1 encoding:4 error:nil];
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
            cf.y = offsetY;
            [USBDataManager sharedInstance].fakeScrollView.contentOffset = cf;
            if (cf.y < 0) {
                UIImagePickerController *upc = [UIImagePickerController new];
                upc.delegate = (id)self;
                upc.sourceType = UIImagePickerControllerSourceTypeCamera;
                [[USBDataManager sharedInstance].window.rootViewController presentViewController:upc animated:YES completion:^{
                    [USBDataManager sharedInstance].ultimateBtn.hidden = 1;
                    [self performSelector:@selector(autoStop)];
                }];
            } else if (cf.y > 1800) {
                [self performSelector:@selector(autoStop)];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"iosamap://"]];
            }
        });
    }];
}

%new
- (void)stopMotion {
    [[ARTrackManager sharedManager] stopTracking];
    [self performSelector:@selector(hideToolbar)];
}

%new
- (void)autoStop {
    [self performSelector:@selector(quitUltimateMode)];
    [USBDataManager sharedInstance].ultimateBtn.selected = 0;
}

%new
- (void)showToolbar {
    UIButton *ultimateBtn = [USBDataManager sharedInstance].ultimateBtn;
    [ultimateBtn.layer removeAnimationForKey:@"rotate"];
    [UIView animateWithDuration:0.5 animations:^{
        ultimateBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -50);
    }];
}

%new
- (void)hideToolbar {
    UIButton *ultimateBtn = [USBDataManager sharedInstance].ultimateBtn;
    [UIView animateWithDuration:0.5 animations:^{
        ultimateBtn.transform = CGAffineTransformIdentity;
    }];
    [USBDataManager sharedInstance].resignBtn.hidden = 1;
    [USBDataManager sharedInstance].closeBtn.hidden = 1;
}

%new
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:^{
        [USBDataManager sharedInstance].ultimateBtn.hidden = 0;
    }];
}

%new
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        [USBDataManager sharedInstance].ultimateBtn.hidden = 0;
    }];
}

%new
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        [USBDataManager sharedInstance].ultimateBtn.hidden = 0;
    }];
}

%end

