//
//  ARTrackManager.h
//  ARTracking
//
//  Created by soulghost on 2018/8/23.
//  Copyright © 2018 soulghost. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ARTrackCallback)(float dx, float dy, float dz);

@interface ARTrackManager : NSObject

@property (nonatomic, strong) NSMutableArray *callbacks;

+ (instancetype)sharedManager;
- (void)startTracking;
- (void)stopTracking;
- (void)rebase;

@end
