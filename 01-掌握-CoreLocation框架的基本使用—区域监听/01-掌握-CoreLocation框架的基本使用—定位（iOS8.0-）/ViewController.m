//
//  ViewController.m
//  01-掌握-CoreLocation框架的基本使用—定位（iOS8.0-）
//
//  Created by xiaomage on 15/8/23.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>



/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *lM;

@end

@implementation ViewController

#pragma mark - 懒加载
- (CLLocationManager *)lM
{
    if (!_lM) {
        // 1. 创建位置管理者
        _lM = [[CLLocationManager alloc] init];
        
        _lM.delegate = self;
        
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [_lM requestAlwaysAuthorization];
            _lM.allowsBackgroundLocationUpdates = YES;
        }
    }
    return _lM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //区域监听
    CLLocationCoordinate2D center = {21.13,123.245};
    
    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:center radius:100 identifier:@"test"];
    [self.lM startMonitoringForRegion:region];

    
    CLLocationCoordinate2D center1 = {22.13,123.245};
    
    CLCircularRegion *region1 = [[CLCircularRegion alloc]initWithCenter:center1 radius:100 identifier:@"test1"];
    
    [self.lM startMonitoringForRegion:region1];
    
    //请求区域状态
    [self.lM requestStateForRegion:region1];
}

#pragma mark CLLocationManagerDelegate
/*
 1.调试模拟器 需要点击 Debug ->Location ->Custom Location 修改坐标进行调试
 */
//进入区域
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"进入区域--%@",region.identifier);
    
}
//离开区域
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(nonnull CLRegion *)region{
     NSLog(@"离开区域--%@",region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    
    switch (state) {
        case CLRegionStateUnknown:
            NSLog(@"未知");
            break;
        case CLRegionStateInside:
            NSLog(@"里面");
            break;
        case CLRegionStateOutside:
            NSLog(@"离开");
            break;
        default:
            break;
    }
}
@end
