//
//  DeviceManager.m
//  DeviceHelper
//
//  Created by waitwalker on 2020/12/22.
//

#import "DeviceManager.h"
#import <sys/utsname.h>

@interface DeviceManager()

/// 设备类型
@property(nonatomic, assign, readwrite) DeviceType deviceType;

/// 设备类型 iPhone 7/ iPhone xr...
@property(nonatomic, assign, readwrite) NSString *deviceModelType;

@end

@implementation DeviceManager

@synthesize deviceType = _deviceType;
@synthesize deviceModelType = _deviceModelType;

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
    
    NSString *deviceM = [self deviceModelType];
    
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

- (NSString* )deviceModelType {
    /// https://www.theiphonewiki.com/wiki/Models
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    // iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE (1st generation)";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"])    return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"])    return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone12,1"])    return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"])    return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])    return @"iPhone 11 Pro Max";
    if ([deviceString isEqualToString:@"iPhone12,8"])    return @"iPhone SE (2nd generation)";
    if ([deviceString isEqualToString:@"iPhone13,1"])    return @"iPhone 12 mini";
    if ([deviceString isEqualToString:@"iPhone13,2"])    return @"iPhone 12";
    if ([deviceString isEqualToString:@"iPhone13,3"])    return @"iPhone 12 Pro";
    if ([deviceString isEqualToString:@"iPhone13,4"])    return @"iPhone 12 Pro Max";
    
    
    // AirPods
    if ([deviceString isEqualToString:@"AirPods1,1"])    return @"AirPods (1st generation)";
    if ([deviceString isEqualToString:@"AirPods2,1"])    return @"AirPods (2nd generation)";
    if ([deviceString isEqualToString:@"AirPods8,1"])    return @"AirPods Pro";
    
    
    // Apple TV
    if ([deviceString isEqualToString:@"AppleTV1,1"])    return @"Apple TV (1st generation)";
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV (2nd generation)";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV (3rd generation)";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV (3rd generation)";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV (4th generation)";
    if ([deviceString isEqualToString:@"AppleTV6,2"])    return @"Apple TV 4K";
    
    
    // Apple Watch
    if ([deviceString isEqualToString:@"Watch1,1"])    return @"Apple Watch (1st generation)";
    if ([deviceString isEqualToString:@"Watch1,2"])    return @"Apple Watch (1st generation)";
    if ([deviceString isEqualToString:@"Watch2,6"])    return @"Apple Watch Series 1";
    if ([deviceString isEqualToString:@"Watch2,7"])    return @"Apple Watch Series 1";
    if ([deviceString isEqualToString:@"Watch2,3"])    return @"Apple Watch Series 2";
    if ([deviceString isEqualToString:@"Watch2,4"])    return @"Apple Watch Series 2";
    if ([deviceString isEqualToString:@"Watch3,1"])    return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch3,2"])    return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch3,3"])    return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch3,4"])    return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch4,1"])    return @"Apple Watch Series 4";
    if ([deviceString isEqualToString:@"Watch4,2"])    return @"Apple Watch Series 4";
    if ([deviceString isEqualToString:@"Watch4,3"])    return @"Apple Watch Series 4";
    if ([deviceString isEqualToString:@"Watch4,4"])    return @"Apple Watch Series 4";
    if ([deviceString isEqualToString:@"Watch5,1"])    return @"Apple Watch Series 5";
    if ([deviceString isEqualToString:@"Watch5,2"])    return @"Apple Watch Series 5";
    if ([deviceString isEqualToString:@"Watch5,3"])    return @"Apple Watch Series 5";
    if ([deviceString isEqualToString:@"Watch5,4"])    return @"Apple Watch Series 5";
    if ([deviceString isEqualToString:@"Watch5,9"])    return @"Apple Watch SE";
    if ([deviceString isEqualToString:@"Watch5,10"])    return @"Apple Watch SE";
    if ([deviceString isEqualToString:@"Watch5,11"])    return @"Apple Watch SE";
    if ([deviceString isEqualToString:@"Watch5,12"])    return @"Apple Watch SE";
    if ([deviceString isEqualToString:@"Watch6,1"])    return @"Apple Watch Series 6";
    if ([deviceString isEqualToString:@"Watch6,2"])    return @"Apple Watch Series 6";
    if ([deviceString isEqualToString:@"Watch6,3"])    return @"Apple Watch Series 6";
    if ([deviceString isEqualToString:@"Watch6,4"])    return @"Apple Watch Series 6";
    
    
    // HomePod
    if ([deviceString isEqualToString:@"AudioAccessory1,1"])    return @"HomePod";
    if ([deviceString isEqualToString:@"AudioAccessory1,2"])    return @"HomePod";
    if ([deviceString isEqualToString:@"AudioAccessory5,1"])    return @"HomePod mini";
    
    // iPad
    if ([deviceString isEqualToString:@"iPad1,1"])    return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])    return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,2"])    return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])    return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,4"])    return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,1"])    return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,2"])    return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])    return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad3,1"])    return @"iPad (3rd generation)";
    if ([deviceString isEqualToString:@"iPad3,2"])    return @"iPad (3rd generation)";
    if ([deviceString isEqualToString:@"iPad3,3"])    return @"iPad (3rd generation)";
    if ([deviceString isEqualToString:@"iPad3,4"])    return @"iPad (4th generation)";
    if ([deviceString isEqualToString:@"iPad3,5"])    return @"iPad (4th generation)";
    if ([deviceString isEqualToString:@"iPad3,6"])    return @"iPad (4th generation)";
    if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad (5th generation)";
    if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad (5th generation)";
    if ([deviceString isEqualToString:@"iPad7,5"])    return @"iPad (6th generation)";
    if ([deviceString isEqualToString:@"iPad7,6"])    return @"iPad (6th generation)";
    if ([deviceString isEqualToString:@"iPad7,11"])    return @"iPad (7th generation)";
    if ([deviceString isEqualToString:@"iPad7,12"])    return @"iPad (7th generation)";
    if ([deviceString isEqualToString:@"iPad11,6"])    return @"iPad (8th generation)";
    if ([deviceString isEqualToString:@"iPad11,7"])    return @"iPad (8th generation)";
    // iPad Air
    if ([deviceString isEqualToString:@"iPad4,1"])    return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])    return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])    return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])    return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])    return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad11,3"])    return @"iPad Air (3rd generation)";
    if ([deviceString isEqualToString:@"iPad11,4"])    return @"iPad Air (3rd generation)";
    if ([deviceString isEqualToString:@"iPad13,1"])    return @"iPad Air (4th generation)";
    if ([deviceString isEqualToString:@"iPad13,2"])    return @"iPad Air (4th generation)";
    // iPad Pro
    if ([deviceString isEqualToString:@"iPad6,7"])    return @"iPad Pro (12.9-inch)";
    if ([deviceString isEqualToString:@"iPad6,8"])    return @"iPad Pro (12.9-inch)";
    if ([deviceString isEqualToString:@"iPad6,3"])    return @"iPad Pro (9.7-inch)";
    if ([deviceString isEqualToString:@"iPad6,4"])    return @"iPad Pro (9.7-inch)";
    if ([deviceString isEqualToString:@"iPad7,1"])    return @"iPad Pro (12.9-inch) (2nd generation)";
    if ([deviceString isEqualToString:@"iPad7,2"])    return @"iPad Pro (12.9-inch) (2nd generation)";
    if ([deviceString isEqualToString:@"iPad7,3"])    return @"iPad Pro (10.5-inch)";
    if ([deviceString isEqualToString:@"iPad7,4"])    return @"iPad Pro (10.5-inch)";
    if ([deviceString isEqualToString:@"iPad8,1"])    return @"iPad Pro (11-inch)";
    if ([deviceString isEqualToString:@"iPad8,2"])    return @"iPad Pro (11-inch)";
    if ([deviceString isEqualToString:@"iPad8,3"])    return @"iPad Pro (11-inch)";
    if ([deviceString isEqualToString:@"iPad8,4"])    return @"iPad Pro (11-inch)";
    if ([deviceString isEqualToString:@"iPad8,5"])    return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([deviceString isEqualToString:@"iPad8,6"])    return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([deviceString isEqualToString:@"iPad8,7"])    return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([deviceString isEqualToString:@"iPad8,8"])    return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([deviceString isEqualToString:@"iPad8,9"])    return @"iPad Pro (11-inch) (2nd generation)";
    if ([deviceString isEqualToString:@"iPad8,10"])    return @"iPad Pro (11-inch) (2nd generation)";
    if ([deviceString isEqualToString:@"iPad8,11"])    return @"iPad Pro (12.9-inch) (4th generation)";
    if ([deviceString isEqualToString:@"iPad8,12"])    return @"iPad Pro (12.9-inch) (4th generation)";
    // iPad mini
    if ([deviceString isEqualToString:@"iPad2,5"])    return @"iPad mini";
    if ([deviceString isEqualToString:@"iPad2,6"])    return @"iPad mini";
    if ([deviceString isEqualToString:@"iPad2,7"])    return @"iPad mini";
    if ([deviceString isEqualToString:@"iPad4,5"])    return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,5"])    return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,6"])    return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])    return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])    return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])    return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])    return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"])    return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad11,1"])    return @"iPad mini (5th generation)";
    if ([deviceString isEqualToString:@"iPad11,2"])    return @"iPad mini (5th generation)";
    
    
    // iPod touch
    if ([deviceString isEqualToString:@"iPod1,1"])    return @"iPod touch";
    if ([deviceString isEqualToString:@"iPod2,1"])    return @"iPod touch (2nd generation)";
    if ([deviceString isEqualToString:@"iPod3,1"])    return @"iPod touch (3rd generation)";
    if ([deviceString isEqualToString:@"iPod4,1"])    return @"iPod touch (4th generation)";
    if ([deviceString isEqualToString:@"iPod5,1"])    return @"iPod touch (5th generation)";
    if ([deviceString isEqualToString:@"iPod7,1"])    return @"iPod touch (6th generation)";
    if ([deviceString isEqualToString:@"iPod9,1"])    return @"iPod touch (7th generation)";
    
    
    return deviceString;
}


- (DeviceType)deviceType {
    return [self getDeviceType];
}

@end
