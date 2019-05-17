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
        // 1.1 代理, 通知, block
        _lM.delegate = self;
        
        // 每隔多米定位一次
//        _lM.distanceFilter = 100;
        /**
           kCLLocationAccuracyBestForNavigation // 最适合导航
           kCLLocationAccuracyBest; // 最好的
           kCLLocationAccuracyNearestTenMeters; // 10m
           kCLLocationAccuracyHundredMeters; // 100m
           kCLLocationAccuracyKilometer; // 1000m
           kCLLocationAccuracyThreeKilometers; // 3000m
         */
        // 精确度越高, 越耗电, 定位时间越长
        _lM.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _lM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    // 2. 使用位置管理者,开始更新用户位置
    // 默认只能在前台获取用户位置,
    // 勾选后台模式 location updates
    [self.lM startUpdatingLocation];
    
    
    
}

#pragma mark - CLLocationManagerDelegate
/**
 *  更新到位置之后调用
 *
 *  @param manager   位置管理者
 *  @param locations 位置数组
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"定位到了");
    
    // 拿到位置,做一些业务逻辑操作
    
    
    // 停止更新
//    [manager stopUpdatingLocation];
    
    
    
}



@end
