//
//  USBDataManager.h
//  UltimateSpringBoard
//
//  Created by soulghost on 2018/8/22.
//

#import <UIKit/UIKit.h>

@interface USBDataManager : NSObject

@property (nonatomic, strong) UIImage *snapshot;
@property (nonatomic, strong) UIScrollView *fakeScrollView;
@property (nonatomic, strong) UIButton *ultimateBtn;
@property (nonatomic, strong) UIButton *resignBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, strong) UIScrollView *desktopScrollView;

+ (instancetype)sharedInstance;

@end
