//
//  MonitoringManager.h
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, MonitoringManagerType) {
    MonitoringManager_Default = 1 << 1,
    MonitoringManager_GPU = 1 << 2,
    MonitoringManager_CPU = 1 << 3,
    MonitoringManager_MEMORY = 1 << 4,
    MonitoringManager_FPS = 1 << 5,
    MonitoringManager_NET_STATE = 1 << 6,
    MonitoringManager_NET_DOWNLOAD = 1 << 7,
    MonitoringManager_NET_UPLOAD = 1 << 8,
};

@interface MonitoringManager : NSObject


+ (MonitoringManager *)sharedInstance;

- (void)open;

@property (nonatomic, assign) MonitoringManagerType type;

@end

NS_ASSUME_NONNULL_END
