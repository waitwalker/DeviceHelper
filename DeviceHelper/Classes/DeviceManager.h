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
@property(nonatomic, assign, readonly) NSString *deviceModelType;

@end

NS_ASSUME_NONNULL_END
