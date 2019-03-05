//
//  MonitoringCPU.h
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach/mach.h>
#import <sys/time.h>

NS_ASSUME_NONNULL_BEGIN

@interface MonitoringCPU : NSObject

+ (void)checkCPUSpeed:(void(^)(NSArray<NSString *> *use))used;

@end

NS_ASSUME_NONNULL_END
