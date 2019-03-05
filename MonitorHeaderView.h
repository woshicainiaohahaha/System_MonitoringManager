//
//  MonitorHeaderView.h
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MonitorHeaderViewDelegate <NSObject>

- (void)switchStateChange:(BOOL)on;

@end

@interface MonitorHeaderView : UIView

@property (nonatomic,weak) id <MonitorHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
