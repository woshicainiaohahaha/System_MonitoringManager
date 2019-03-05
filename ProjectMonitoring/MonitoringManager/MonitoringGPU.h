//
//  MonitoringGPU.h
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MonitoringGPU : NSObject

@property (nonatomic, readonly) NSInteger deviceUtilization;    // percent
@property (nonatomic, readonly) NSInteger rendererUtilization;  // percent
@property (nonatomic, readonly) NSInteger tilerUtilization;     // percent
@property (nonatomic, readonly) int64_t hardwareWaitTime;                   // nano second
@property (nonatomic, readonly) int64_t finishGLWaitTime;                   // nano second
@property (nonatomic, readonly) int64_t freeToAllocGPUAddressWaitTime;      // nano second
@property (nonatomic, readonly) NSInteger contextGLCount;
@property (nonatomic, readonly) NSInteger renderCount;
@property (nonatomic, readonly) NSInteger recoveryCount;
@property (nonatomic, readonly) NSInteger textureCount;

@property (nonatomic, class, readonly) float gpuUsage;

+ (void)fetchCurrentUtilization:(NS_NOESCAPE void(^)(MonitoringGPU *current))block;


@end

NS_ASSUME_NONNULL_END
