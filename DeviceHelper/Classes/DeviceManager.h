//
//  DeviceManager.h
//  DeviceHelper
//
//  Created by waitwalker on 2020/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 设备类型
typedef enum : NSInteger {
    iPhone = 1,
    iPad = 2,
    iPod = 3,
    TV = 4,
    CarPlay = 5,
    Mac = 6,
    unkonwn = -1,
} DeviceType;

@interface DeviceManager : NSObject

/**
 * description: 单例
 *
 * author: waitwalker
 */

+ (instancetype)sharedManager;

/// 设备种类 iPhone/iPad... 只读
@property(nonatomic, assign, readonly) DeviceType deviceType;

/// 设备型号 iPhone 7/ iPhone xr...
@property(nonatomic, copy, readonly) NSString *deviceModelType;

/// 设备唯一标识符
@property(nonatomic, copy, readonly) NSString *deviceIdentifier;

/// 设备名称
@property(nonatomic, copy, readonly) NSString *deviceName;

/// 设备系统版本
@property(nonatomic, copy, readonly) NSString *deviceSystemVersion;

/// 设备国际化区域
@property(nonatomic, copy, readonly) NSString *deviceLocal;

/// 屏幕分辨率宽
@property(nonatomic, assign, readonly) CGFloat screenResolutionWidth;

/// 屏幕分辨率高
@property(nonatomic, assign, readonly) CGFloat screenResolutionHeight;

/// 屏幕物理宽
@property(nonatomic, assign, readonly) CGFloat screenPhysicalWidth;

/// 屏幕物理高
@property(nonatomic, assign, readonly) CGFloat screenPhysicalHeight;

/// 设备运营商
@property(nonatomic, copy, readonly) NSString *carrierName;


@end

NS_ASSUME_NONNULL_END
