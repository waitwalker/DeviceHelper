//
//  DeviceManager.m
//  DeviceHelper
//
//  Created by waitwalker on 2020/12/22.
//

#import "DeviceManager.h"

@interface DeviceManager()

/// 设备类型
@property(nonatomic, assign, readwrite) DeviceType deviceType;

@end

@implementation DeviceManager

@synthesize deviceType = _deviceType;

+ (instancetype)sharedManager {
    static DeviceManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[DeviceManager alloc]init];
        }
    });
    return _manager;
}

- (DeviceType)getDeviceType {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return iPhone;
    } else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return iPad;
    } else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomTV) {
        return TV;
    } else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomCarPlay) {
        return CarPlay;
    } else if (@available(iOS 14.0, *)) {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomMac) {
            return Mac;
        }
    } else {
        return unkonwn;
    }
    return unkonwn;
}


- (DeviceType)deviceType {
    return [self getDeviceType];
}

@end
