//
//  MonitoringHeader.h
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#ifndef MonitoringHeader_h
#define MonitoringHeader_h

#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif

#define WeakSelf(type)  __weak typeof(type) weak##type = type;

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define STATUSBARHEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#define MONITORWIDTH 150

#define TABLEHEIGHT 28

#define TABLE_HEADER_HEIGHT 35

#import "MonitoringFPS.h"
#import "MonitoringGPU.h"
#import "MonitoringNet.h"
#import "MonitoringCPU.h"

#endif /* MonitoringHeader_h */
