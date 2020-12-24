//
//  DeviceManager.m
//  DeviceHelper
//
//  Created by waitwalker on 2020/12/22.
//

#import "DeviceManager.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AVFoundation/AVFoundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#include <sys/stat.h>
#include <dlfcn.h>
#import <UserNotifications/UserNotifications.h>
#include <mach/mach_host.h>

@interface DeviceManager()

/// 设备种类 iPhone/iPad... 只读
@property(nonatomic, assign, readwrite) DeviceType deviceType;

/// 设备型号 iPhone 7/ iPhone xr...
@property(nonatomic, copy, readwrite) NSString *deviceModelType;

/// 设备唯一标识符
@property(nonatomic, copy, readwrite) NSString *deviceIdentifier;

/// 设备名称
@property(nonatomic, copy, readwrite) NSString *deviceName;

/// 设备系统版本
@property(nonatomic, copy, readwrite) NSString *deviceSystemVersion;

/// 设备国际化区域
@property(nonatomic, copy, readwrite) NSString *deviceLocal;

/// 屏幕分辨率宽
@property(nonatomic, assign, readwrite) CGFloat screenResolutionWidth;

/// 屏幕分辨率高
@property(nonatomic, assign, readwrite) CGFloat screenResolutionHeight;

/// 屏幕物理宽
@property(nonatomic, assign, readwrite) CGFloat screenPhysicalWidth;

/// 屏幕物理高
@property(nonatomic, assign, readwrite) CGFloat screenPhysicalHeight;

/// 屏幕亮度
@property(nonatomic, assign, readwrite) CGFloat screenBrightness;

/// 设备运营商
@property(nonatomic, copy, readwrite) NSString *carrierName;

/// 设备是否插入sim卡
@property(nonatomic, assign, readwrite) BOOL isSimInserted;

/// 设备是否越狱
@property(nonatomic, assign, readwrite) BOOL isJailBreak;

/// 设备是否连接代理
@property(nonatomic, assign, readwrite) BOOL isProxy;

/// 设备磁盘大小
@property(nonatomic, assign, readwrite) long diskTotalSize;

/// 设备磁盘剩余空间大小
@property(nonatomic, assign, readwrite) long diskFreeSize;

/// 设备运行内存大小
@property(nonatomic, assign, readwrite) long memoryTotalSize;

/// 设备运行内存剩余空间大小
@property(nonatomic, assign, readwrite) long memoryFreeSize;

/// 设备当前电量
@property(nonatomic, assign, readwrite) CGFloat batteryLevel;

/// 设备电池状态
@property(nonatomic, copy, readwrite) NSString *batteryState;

/// 设备当前音量
@property(nonatomic, assign, readwrite) CGFloat deviceVolume;

/// 设备WiFi名称
@property(nonatomic, copy, readwrite) NSString *WiFiName;

/// 设备内网ip地址
@property(nonatomic, copy, readwrite) NSString *intranetIPAddress;

/// 设备外网ip地址
@property(nonatomic, copy, readwrite) NSString *externalIPAddress;

@end

@implementation DeviceManager

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

- (NSString* )getDeviceModelType {
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
    
    // Simulator
    if ([deviceString isEqualToString:@"x86_64"])    return @"Simulator";
    
    return deviceString;
}


- (DeviceType)deviceType {
    return [self getDeviceType];
}

- (NSString *)deviceModelType {
    return [self getDeviceModelType];
}

- (NSString *)deviceIdentifier {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

- (NSString *)deviceSystemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)deviceLocal {
    return [[UIDevice currentDevice] localizedModel];
}

- (CGFloat)screenPhysicalWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

- (CGFloat)screenPhysicalHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

- (CGFloat)screenResolutionWidth {
    return [[UIScreen mainScreen] bounds].size.width * [UIScreen mainScreen].scale;
}

- (CGFloat)screenResolutionHeight {
    return [[UIScreen mainScreen] bounds].size.height * [UIScreen mainScreen].scale;
}

- (CGFloat)screenBrightness {
    return [UIScreen mainScreen].brightness;
}

- (NSString *)carrierName {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    return carrier.carrierName;
}

- (BOOL)isSimInserted {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    if (!carrier.isoCountryCode) {
        return NO;
    }
    return YES;
}

- (BOOL)isJailBreak {
    //以下检测的过程是越往下，越狱越高级
    //获取越狱文件路径
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }
    
    //可能存在hook了NSFileManager方法，此处用底层C stat去检测
    struct stat stat_info;
    if (0 == stat("/Library/MobileSubstrate/MobileSubstrate.dylib", &stat_info)) {
        return YES;
    }
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        return YES;
    }
    if (0 == stat("/var/lib/cydia/", &stat_info)) {
        return YES;
    }
    if (0 == stat("/var/cache/apt", &stat_info)) {
        return YES;
    }
    
    //可能存在stat也被hook了，可以看stat是不是出自系统库，有没有被攻击者换掉。这种情况出现的可能性很小
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char *,struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        //相等为0，不相等，肯定被攻击
        if (strcmp(dylib_info.dli_fname, "/usr/lib/system/libsystem_kernel.dylib")) {
            return YES;
        }
    }
    
    //通常，越狱机的输出结果会包含字符串：Library/MobileSubstrate/MobileSubstrate.dylib。
    //攻击者给MobileSubstrate改名，原理都是通过DYLD_INSERT_LIBRARIES注入动态库。那么可以检测当前程序运行的环境变量
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env != NULL) {
        return YES;
    }
        
    return NO;
}

- (BOOL)isProxy {
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com/"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    if (![[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        return YES;
    }
    return NO;
}

- (CGFloat)batteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [[UIDevice currentDevice] batteryLevel];
}

- (NSString *)batteryState {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    UIDeviceBatteryState batteryState = [UIDevice currentDevice].batteryState;
    switch (batteryState) {
        case UIDeviceBatteryStateUnplugged:
            return @"未充电";
        case UIDeviceBatteryStateCharging:
            return @"充电中";
        case UIDeviceBatteryStateFull:
            return @"已充满";
        default:
            return @"未知";
    }
}


- (CGFloat)deviceVolume {
    return [[AVAudioSession sharedInstance] outputVolume];
}

- (NSString *)WiFiName {
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dctySSID = (NSDictionary *)info;
    
    return [dctySSID objectForKey:@"SSID"];
}

- (NSString *)intranetIPAddress {
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) return nil;
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    return ips.lastObject;
}

- (NSString *)externalIPAddress {
    //请求url
    NSURL *url = [NSURL URLWithString:@"https://pv.sohu.com/cityjson?ie=utf-8"];
    NSMutableString *mString = [NSMutableString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //判断返回字符串是否为所需数据
    if ([mString hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，获取json数据
        [mString deleteCharactersInRange:NSMakeRange(0, 19)];
        NSString *jsonStr = [mString substringToIndex:mString.length - 1];
        //对Json字符串进行Json解析
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dict[@"cip"];
    }
    return nil;
}

- (long)diskTotalSize {
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *diskTotalSize = [systemAttributes objectForKey:NSFileSystemSize];
    return (long)(diskTotalSize.floatValue / 1024.f / 1024.f);
}

- (long)diskFreeSize {
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *diskFreeSize = [systemAttributes objectForKey:NSFileSystemFreeSize];
    return (long)(diskFreeSize.floatValue / 1024.f / 1024.f);
}

- (long)memoryTotalSize {
    long long total = [NSProcessInfo processInfo].physicalMemory;
    return (long)(total / 1024.f / 1024.f);
}

- (long)memoryFreeSize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    long long free = ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
    return (long)(free / 1024.f / 1024.f);
}



@end
