//
//  MonitorHeaderView.m
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import "MonitorHeaderView.h"
#import "MonitoringHeader.h"

@interface MonitorHeaderView ()

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UISwitch *switchBtn;

@property (nonatomic, strong) UILabel *switchLab;

@end

@implementation MonitorHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.topView.frame = CGRectMake(0, 0, MONITORWIDTH, TABLE_HEADER_HEIGHT);
        self.switchLab.frame = CGRectMake(15, 0, 70, TABLE_HEADER_HEIGHT);
        self.switchBtn.frame = CGRectMake(MONITORWIDTH-55, 0, 40, TABLE_HEADER_HEIGHT);
        [self.topView addSubview:self.switchLab];
        [self.topView addSubview:self.switchBtn];
        [self addSubview:self.topView];
    }
    return self;
}

- (void)switchClick:(UISwitch *)sw {
    sw.on = !sw.on;
    if (_delegate && [_delegate respondsToSelector:@selector(switchStateChange:)]) {
        [_delegate switchStateChange:sw.on];
    }
}


- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.tag = 101;
    }
    return _topView;
}

- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        [_switchBtn setOn:YES];
        [_switchBtn addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

- (UILabel *)switchLab {
    if (!_switchLab) {
        _switchLab = [[UILabel alloc] init];
        _switchLab.textColor = [UIColor colorWithRed:31/255.0 green:11/255.0 blue:181/255.0 alpha:1];
        _switchLab.text = @"控制开关:";
        _switchLab.font = [UIFont boldSystemFontOfSize:14];
    }
    return _switchLab;
}

@end
