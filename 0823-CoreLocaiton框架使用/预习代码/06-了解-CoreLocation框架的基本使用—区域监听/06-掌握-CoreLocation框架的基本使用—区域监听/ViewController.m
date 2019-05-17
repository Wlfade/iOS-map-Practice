//
//  ViewController.m
//  06-掌握-CoreLocation框架的基本使用—区域监听
//
//  Created by 王顺子 on 15/8/5.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationM;

@end

@implementation ViewController

#pragma mark - 懒加载
-(CLLocationManager *)locationM
{
    if (!_locationM) {
        _locationM = [[CLLocationManager alloc] init];
        _locationM.delegate = self;
        if ([_locationM respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationM requestAlwaysAuthorization];
        }
    }
    return _locationM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建区域中心
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(29.12345, 131.23456);
    // 创建区域（指定区域中心，和区域半径）
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:1000 identifier:@"小码哥"];
    // 开始监听指定区域
    [self.locationM startMonitoringForRegion:region];
}

#pragma mark - CLLocationManagerDelegate

// 进去监听区域后调用（调用一次）
-(void)locationManager:(nonnull CLLocationManager *)manager didEnterRegion:(nonnull CLRegion *)region
{
    NSLog(@"进入区域---%@", region.identifier);
    [manager stopMonitoringForRegion:region];
}

// 离开监听区域后调用（调用一次）
-(void)locationManager:(nonnull CLLocationManager *)manager didExitRegion:(nonnull CLRegion *)region
{
    NSLog(@"离开区域---%@", region.identifier);
}


@end
