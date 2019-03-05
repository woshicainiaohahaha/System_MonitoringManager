//
//  MonitoringNet.h
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MonitoringNet : NSObject

// 88kB/s
extern NSString *const GSDownloadNetworkSpeedNotificationKey;
// 2MB/s
extern NSString *const GSUploadNetworkSpeedNotificationKey;
@property (nonatomic, copy, readonly) NSString *downloadNetworkSpeed;
@property (nonatomic, copy, readonly) NSString *uploadNetworkSpeed;
@property (nonatomic, copy, readonly) NSString *currentNetType;

- (void)checkNetworkSpeed:(void(^)(NSArray<NSString *> *speed))download;

@end

NS_ASSUME_NONNULL_END
