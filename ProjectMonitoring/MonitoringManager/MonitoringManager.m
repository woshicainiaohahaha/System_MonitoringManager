//
//  MonitoringManager.m
//  ProjectMonitoring
//
//  Created by 李东岩 on 2019/3/4.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import "MonitoringManager.h"
#import "MonitorHeaderView.h"
#import "MonitoringHeader.h"
#import "MonitorModel.h"

@interface MonitoringManager ()<UITableViewDataSource,UITableViewDelegate,MonitorHeaderViewDelegate>
{
    NSTimer *timer;
}

@property (nonatomic, strong) UITableView *dataTable;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MonitoringFPS *monitorFPS;

@property (nonatomic, strong) MonitoringNet *monitorNET;

@end

@implementation MonitoringManager

+ (MonitoringManager *)sharedInstance {
    static MonitoringManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MonitoringManager alloc] init];
    });
    return manager;
}

- (id)init {
    self = [super init];
    if (self) {
        // Track using display link
        [self addToWindows];
    }
    return self;
}

- (void)addToWindows {
//    NSArray *rootVCViewSubViews=[[UIApplication sharedApplication].delegate window].rootViewController.view.subviews;
//    for (UIView *view in rootVCViewSubViews) {
//        if ([view isKindOfClass:[UIView class]]&& view.tag==101) {
//            return;
//        }
//    }
    
    MonitorHeaderView *headerView = [[MonitorHeaderView alloc] initWithFrame:CGRectMake(0, 0, MONITORWIDTH, TABLE_HEADER_HEIGHT)];
    headerView.delegate = self;
    self.dataTable.tableHeaderView = headerView;
    
    [[((NSObject <UIApplicationDelegate> *)([UIApplication sharedApplication].delegate)) window].rootViewController.view addSubview:self.dataTable];
}

- (void)open {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerOn) userInfo:nil repeats:YES];
    [timer fire];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [self creatDataArray];
    self.dataTable.frame = CGRectMake(WIDTH - MONITORWIDTH - 10, STATUSBARHEIGHT, MONITORWIDTH, self.dataArray.count*TABLEHEIGHT+TABLE_HEADER_HEIGHT);
    [self.dataTable reloadData];
}
- (void)openWithHandler:(void (^)(NSDictionary *msgValue))handler{}

- (void)close {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    [self.dataArray removeAllObjects];
    [self.dataTable reloadData];
}

- (void)creatDataArray {
    self.dataArray = [NSMutableArray array];
    
    MonitorModel *fpsModel = [MonitorModel new];
    fpsModel.keyString = @"当前帧率：";
    fpsModel.type = MonitoringModelType_FPS;
    fpsModel.valueString = @"0";
    
    MonitorModel *gpuModel = [MonitorModel new];
    gpuModel.keyString = @"GPU使用率：";
    gpuModel.type = MonitoringModelType_GPU;
    gpuModel.valueString = @"0";
    
    MonitorModel *cpuModel = [MonitorModel new];
    cpuModel.keyString = @"CPU使用率：";
    cpuModel.type = MonitoringModelType_CPU;
    cpuModel.valueString = @"0";
    
    MonitorModel *memoryModel = [MonitorModel new];
    memoryModel.keyString = @"内存占用：";
    memoryModel.type = MonitoringModelType_MEMORY;
    memoryModel.valueString = @"0";
    
    MonitorModel *netModel = [MonitorModel new];
    netModel.keyString = @"网络类型：";
    netModel.type = MonitoringModelType_NET_STATE;
    netModel.valueString = @"0";
    
    MonitorModel *netDownLoadModel = [MonitorModel new];
    netDownLoadModel.keyString = @"下载速率：";
    netDownLoadModel.type = MonitoringModelType_NET_DOWNLOAD;
    netDownLoadModel.valueString = @"0";
    
    MonitorModel *netUpLoadModel = [MonitorModel new];
    netUpLoadModel.keyString = @"上传速率：";
    netUpLoadModel.type = MonitoringModelType_NET_UPLOAD;
    netUpLoadModel.valueString = @"0";
    
    if (self.type & MonitoringManager_Default) {
        [self.dataArray addObject:fpsModel];
        [self.dataArray addObject:gpuModel];
        [self.dataArray addObject:cpuModel];
        [self.dataArray addObject:memoryModel];
        [self.dataArray addObject:netModel];
        [self.dataArray addObject:netDownLoadModel];
        [self.dataArray addObject:netUpLoadModel];
        [self addMonitor];
        return;
    }
    
    if (self.type & MonitoringManager_FPS) {
        [self.dataArray addObject:fpsModel];
        [self addMonitor];
    }
    
    if (self.type & MonitoringManager_GPU) {
        [self.dataArray addObject:gpuModel];
    }
    
    if (self.type & MonitoringManager_CPU) {
        [self.dataArray addObject:cpuModel];
    }
    
    if (self.type & MonitoringManager_MEMORY) {
        [self.dataArray addObject:memoryModel];
    }
    
    if (self.type & MonitoringManager_NET_STATE) {
        [self.dataArray addObject:netModel];
    }
    
    if (self.type & MonitoringManager_NET_DOWNLOAD) {
        [self.dataArray addObject:netDownLoadModel];
    }
    
    if (self.type & MonitoringManager_NET_UPLOAD) {
        [self.dataArray addObject:netUpLoadModel];
    }
}

- (void)addMonitor{
    __block MonitorModel *fpsModel;


    WeakSelf(self)
    [self.dataArray enumerateObjectsUsingBlock:^(MonitorModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type == MonitoringModelType_FPS) {
            fpsModel = obj;
        }
    }];
    
    if (fpsModel) {
        self.monitorFPS = [[MonitoringFPS alloc] init];
        [self.monitorFPS openWithHandler:^(NSInteger fpsValue) {
            fpsModel.valueString = [NSString stringWithFormat:@"%ldfps",fpsValue];
            [weakself.dataTable reloadData];
        }];
    }
}

- (void)timerOn {
    WeakSelf(self)
    [self refreshUIBlock:^{
        [weakself.dataTable reloadData];
    }];
}

- (void)refreshUIBlock:(void(^)(void))block {
    
    __block MonitorModel *gpuModel;
    __block MonitorModel *cpuModel;
    __block MonitorModel *memoryModel;
    __block MonitorModel *netModel;
    __block MonitorModel *netUpLoadModel;
    __block MonitorModel *netDownLoadModel;
    
    
    [self.dataArray enumerateObjectsUsingBlock:^(MonitorModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type == MonitoringModelType_GPU) {
            gpuModel = obj;
        }
        if (obj.type == MonitoringModelType_CPU) {
            cpuModel = obj;
        }
        if (obj.type == MonitoringModelType_MEMORY) {
            memoryModel = obj;
        }
        if (obj.type == MonitoringModelType_NET_STATE) {
            netModel = obj;
        }
        if (obj.type == MonitoringModelType_NET_DOWNLOAD) {
            netDownLoadModel = obj;
        }
        if (obj.type == MonitoringModelType_NET_UPLOAD) {
            netUpLoadModel = obj;
        }
    }];
    
    if (gpuModel) {
        [MonitoringGPU fetchCurrentUtilization:^(MonitoringGPU * _Nonnull current) {
            gpuModel.valueString = [NSString stringWithFormat:@"%2zd%%", current.deviceUtilization];
        }];
    }

    if (cpuModel || memoryModel) {
        [MonitoringCPU checkCPUSpeed:^(NSArray<NSString *> * _Nonnull use) {
            cpuModel.valueString = use[0];
            memoryModel.valueString = use[1];
        }];
    }
    
    if (netUpLoadModel || netDownLoadModel || netModel) {
        self.monitorNET = [[MonitoringNet alloc] init];
        [self.monitorNET checkNetworkSpeed:^(NSArray<NSString *> * _Nonnull speed) {
            netUpLoadModel.valueString = speed[1];
            netDownLoadModel.valueString = speed[0];
            netModel.valueString = speed[2];
        }];
    }
    block();
}

- (void)removeMonitor {
    [self.monitorFPS close];
}

#pragma  mark delegate/datasource


- (UITableView *)dataTable {
    if (!_dataTable) {
        _dataTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _dataTable.backgroundColor = [UIColor clearColor];
        _dataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTable.dataSource = self;
        _dataTable.delegate = self;
    }
    return _dataTable;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MonitorModel *model = self.dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:11];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = model.keyString;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    cell.detailTextLabel.textColor = [UIColor colorWithRed:31/255 green:111/255 blue:181/255 alpha:1];
    [cell.detailTextLabel adjustsFontSizeToFitWidth];
    cell.detailTextLabel.text = model.valueString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TABLEHEIGHT;
}

- (void)switchStateChange:(BOOL)on {
    on?[self open]:[self close];
}

@end
