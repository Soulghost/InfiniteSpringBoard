//
//  USBMotionManager.h
//  UltimateSpringBoard
//
//  Created by soulghost on 2018/8/22.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CMMotionManager.h>

@interface USBMotionTranslate : NSObject

@property (nonatomic, assign) double dx;
@property (nonatomic, assign) double dy;
@property (nonatomic, assign) double dz;

@end

@interface USBMotionManager : NSObject

+ (USBMotionTranslate *)translateFromMotion:(CMDeviceMotion *)m;

@end
