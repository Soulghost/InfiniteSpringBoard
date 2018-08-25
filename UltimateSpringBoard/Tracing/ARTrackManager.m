//
//  ARTrackManager.m
//  ARTracking
//
//  Created by soulghost on 2018/8/23.
//  Copyright © 2018 soulghost. All rights reserved.
//

#import "ARTrackManager.h"
#import <ARKit/ARKit.h>

@interface ARTrackManager () <ARSessionDelegate>

@property (nonatomic, strong) ARSession *session;
@property (nonatomic, assign) BOOL running;

@property (nonatomic, assign) float x_pre;
@property (nonatomic, assign) float x_base;
@property (nonatomic, assign) BOOL hasInitX;
@property (nonatomic, assign) BOOL findXBase;

@property (nonatomic, assign) float y_pre;
@property (nonatomic, assign) float y_base;
@property (nonatomic, assign) BOOL hasInitY;
@property (nonatomic, assign) BOOL findYBase;

@property (nonatomic, assign) float z_pre;
@property (nonatomic, assign) float z_base;
@property (nonatomic, assign) BOOL hasInitZ;
@property (nonatomic, assign) BOOL findZBase;

@end

@implementation ARTrackManager

+ (instancetype)sharedManager {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ARTrackManager new];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _session = [ARSession new];
        _session.delegate = self;
    }
    return self;
}

- (void)startTracking {
    if (self.running) {
        return;
    }
    [self rebase];
    [self.session runWithConfiguration:[ARWorldTrackingConfiguration new]];
    self.running = YES;
}

- (void)stopTracking {
    if (!self.running) {
        return;
    }
    [self.session pause];
    self.running = NO;
}

- (void)rebase {
    self.findXBase = self.findYBase = self.findZBase = NO;
    self.x_base = self.y_base = self.z_base = 0;
    self.hasInitX = self.hasInitY = self.hasInitZ = NO;
    self.x_pre = self.y_pre = self.z_pre = 0;
}

float calculateOffset(float val, float *pre, float *base, BOOL *hasInit, BOOL *findBase) {
    if (!(*hasInit) && val < 0.0000001f) {
        NSLog(@"init");
        return 0;
    } else {
        *hasInit = YES;
    }
    if (!(*findBase) && fabs(val - *pre) < 0.01f) {
        NSLog(@"value is stable at %f", val);
        *base = val;
        *findBase = YES;
        return 0;
    }
    float offset = val - *base;
    *pre = val;
    return offset;
}

#pragma mark - ARSessionDelegate
- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
    matrix_float4x4 mat33 = frame.camera.transform;
    simd_float4 pos = mat33.columns[3];
    float x = pos[0];
    float y = pos[1];
    float z = pos[2];
    float offsetX = calculateOffset(x, &_x_pre, &_x_base, &_hasInitX, &_findXBase);
    float offsetY = calculateOffset(y, &_y_pre, &_y_base, &_hasInitY, &_findYBase);
    float offsetZ = calculateOffset(z, &_z_pre, &_z_base, &_hasInitZ, &_findZBase);
    if (self.hasInitX && self.hasInitY) {
        for (ARTrackCallback callback in self.callbacks) {
            callback(offsetX, offsetY, offsetZ);
        }
    }
    //    NSLog(@"%f %f %f %f", frame.camera.transform.columns[0], frame.camera.transform.columns[1], frame.camera.transform.columns[2], frame.camera.transform.columns[3]);
    /**
     The camera intrinsics.
     @discussion The matrix has the following contents:
     fx 0   px
     0  fy  py
     0  0   1
     fx and fy are the focal length in pixels.
     px and py are the coordinates of the principal point in pixels.
     The origin is at the center of the upper-left pixel.
     */
    //    matrix_float3x3 mat33 = frame.camera.intrinsics;
    //    simd_float3 c0 = mat33.columns[0];
    //    simd_float3 c1 = mat33.columns[1];
    //    simd_float3 c2 = mat33.columns[2];
    //    NSLog(@"fx=%f, fy=%f, px=%f, py=%f, 1=%f", c0[0], c1[1], c2[0], c2[1], c2[2]);
//    NSMutableString *output = @"\n".mutableCopy;
//    matrix_float4x4 mat44 = frame.camera.transform;
//    for (int i = 0; i < 4; i++) {
//        for (int j = 0; j < 4; j++) {
//            simd_float4 ci = mat44.columns[i];
//            float val = ci[j];
//            [output appendFormat:@"%f ", val];
//        }
//        [output appendFormat:@"\n"];
//    }
//    NSLog(@"%@", output);
}

- (NSMutableArray *)callbacks {
    if (_callbacks == nil) {
        _callbacks = @[].mutableCopy;
    }
    return _callbacks;
}

@end
