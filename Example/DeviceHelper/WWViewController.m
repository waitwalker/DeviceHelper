//
//  WWViewController.m
//  DeviceHelper
//
//  Created by waitwalker on 12/22/2020.
//  Copyright (c) 2020 waitwalker. All rights reserved.
//

#import "WWViewController.h"
#import <DeviceHelper/DeviceManager.h>


@interface WWViewController ()

@end

@implementation WWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    DeviceType deviceType = [DeviceManager sharedManager].deviceType;
    NSLog(@"设备类型:%ld", deviceType);
    
    NSString *deviceModelType = [DeviceManager sharedManager].deviceModelType;
    NSLog(@"设备型号:%@",deviceModelType);
    
    NSLog(@"设备唯一标识符:%@", [DeviceManager sharedManager].deviceIdentifier);
    NSLog(@"设备名称:%@", [DeviceManager sharedManager].deviceName);
    NSLog(@"设备系统版本:%@", [DeviceManager sharedManager].deviceSystemVersion);
    NSLog(@"设备国际化区域名称:%@", [DeviceManager sharedManager].deviceLocal);
    NSLog(@"设备运营商:%@", [DeviceManager sharedManager].carrierName);
    
    NSLog(@"设备物理尺寸宽:%.f 高:%.f",[DeviceManager sharedManager].screenPhysicalWidth, [DeviceManager sharedManager].screenPhysicalHeight);
    NSLog(@"设备分辨率尺寸宽:%.f 高:%.f",[DeviceManager sharedManager].screenResolutionWidth, [DeviceManager sharedManager].screenResolutionHeight);
    
    
    NSLog(@"设备内网ip:%@", [DeviceManager sharedManager].intranetIPAddress);
    NSLog(@"设备外网ip:%@", [DeviceManager sharedManager].externalIPAddress);
    
    NSLog(@"设备总存储空间:%ld", [DeviceManager sharedManager].diskTotalSize);
    NSLog(@"设备可用存储空间:%ld", [DeviceManager sharedManager].diskFreeSize);
    
    NSLog(@"设备总内存空间:%ld", [DeviceManager sharedManager].memoryTotalSize);
    NSLog(@"设备可用内存空间:%ld", [DeviceManager sharedManager].memoryFreeSize);
    NSLog(@"设备是否代理:%d", [DeviceManager sharedManager].isProxy);
    
    
    #warning 该方法是私有API，上线会被拒
    // 由于每款手机同一颜色具体色号不一样，如 iPhone 6和 iPhone SE粉色的两个具体色值是不一样的，因此在这里只能返回一个色号
    UIDevice *device = [UIDevice currentDevice];
    SEL selector = NSSelectorFromString(@"deviceInfoForKey:");
    if (![device respondsToSelector:selector]) {
        selector = NSSelectorFromString(@"_deviceInfoForKey:");
    }
    if ([device respondsToSelector:selector]) {
        // 消除警告“performSelector may cause a leak because its selector is unknown”
        IMP imp = [device methodForSelector:selector];
        NSString * (*func)(id, SEL, NSString *) = (void *)imp;
    
        NSString *deviceColor  = func(device, selector, @"DeviceColor");
        NSString *deviceEnclosureColor  = func(device, selector, @"DeviceEnclosureColor");
        NSLog(@"deviceColor --> %@  deviceEnclosureColor --> %@ ", deviceColor, deviceEnclosureColor);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
