//
//  USBResource.m
//  UltimateSpringBoard
//
//  Created by soulghost on 2018/8/23.
//

#import "USBResource.h"

#define BundlePath @"/Library/MobileSubstrate/DynamicLibraries/UltimateSpringBoard.bundle"

NSString * const UR_UltimateButton_Normal;

@implementation USBResource

+ (UIImage *)imageNamed:(NSString *)name {
    return [UIImage imageWithContentsOfFile:[BundlePath stringByAppendingPathComponent:name]];
}

@end
