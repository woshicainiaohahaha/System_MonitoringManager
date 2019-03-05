//
//  MonitorModel.h
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MonitoringModelType) {
    MonitoringModelType_FPS,
    MonitoringModelType_GPU,
    MonitoringModelType_CPU,
    MonitoringModelType_MEMORY,
    MonitoringModelType_NET_STATE,
    MonitoringModelType_NET_UPLOAD,
    MonitoringModelType_NET_DOWNLOAD,
};
NS_ASSUME_NONNULL_BEGIN

@interface MonitorModel : NSObject

@property (nonatomic, copy) NSString *keyString;

@property (nonatomic, copy) NSString *valueString;

@property (nonatomic, assign) MonitoringModelType type;

@end

NS_ASSUME_NONNULL_END
