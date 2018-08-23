//
//  USBMotionManager.m
//  UltimateSpringBoard
//
//  Created by soulghost on 2018/8/22.
//

#import "USBMotionManager.h"

static double tx = 0;
static double ty = 0;
static double tz = 0;
double vx = 0;
double vy = 0;
double vz = 0;

double a2dx(double a, double *v, double *t);

@implementation USBMotionTranslate

@end

@implementation USBMotionManager

+ (USBMotionTranslate *)translateFromMotion:(CMDeviceMotion *)m {
    double ax = m.userAcceleration.x;
    double ay = m.userAcceleration.y;
    double az = m.userAcceleration.z;
    USBMotionTranslate *t = [USBMotionTranslate new];
    t.dx = a2dx(ax, &vx, &tx);
    t.dy = a2dx(ay, &vy, &ty);
    t.dz = a2dx(az, &vz, &tz);
    return t;
}

@end

double a2dx(double a, double *v, double *t) {
    static double thres = 0.01;
    static double descend_rate = 0.2;
    if (fabs(*t) < 0.001f) {
        *t = [NSDate date].timeIntervalSince1970;
        return 0;
    }
    double ax = a;
    double dt = [NSDate date].timeIntervalSince1970 - *t;
    double dv = 0;
    // 滤除扰动，并且减速
    if (fabs(ax) < thres) {
        dv = v > 0 ? (*v) * -descend_rate : fabs(*v) * descend_rate;
    }
    if (ax < -thres) {
        dv = ax * dt;
    } else if (ax > thres) {
        dv = ax * dt;
    }
    // 速度积分
    (*v) = (*v) + dv;
    *t = [NSDate date].timeIntervalSince1970;
    return (*v) * dt;
}
