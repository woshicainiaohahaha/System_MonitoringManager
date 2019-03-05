//
//  MonitoringFPS.h
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MonitoringFPS : NSObject

- (void)openWithHandler:(void (^)(NSInteger fpsValue))handler;
- (void)close;

@end

NS_ASSUME_NONNULL_END
