//
//  USBDataManager.m
//  UltimateSpringBoard
//
//  Created by soulghost on 2018/8/22.
//

#import "USBDataManager.h"

@implementation USBDataManager

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [USBDataManager new];
    });
    return instance;
}

@end
