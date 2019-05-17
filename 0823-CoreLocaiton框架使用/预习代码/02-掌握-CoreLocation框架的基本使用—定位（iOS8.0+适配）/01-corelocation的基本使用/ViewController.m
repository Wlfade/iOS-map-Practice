//
//  ViewController.m
//  01-corelocation的基本使用
//
//  Created by 王顺子 on 15/8/4.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

// 位置管理者
@property (nonatomic, strong) CLLocationManager *locationM;


@end

@implementation ViewController

#pragma mark - 懒加载对象，并在懒加载方法中进行部分初始化操作
- (CLLocationManager *)locationM
{
    if (!_locationM) {
        // 创建位置管理器
        _locationM = [[CLLocationManager alloc] init];
        // 设置代理
        _locationM.delegate = self;

        /** ------附加设置------- */

        // 设置定位距离过滤参数 （当上次定位和本次定位之间的距离 >= 此值时，才会调用代理通知开发者）
//        _locationM.distanceFilter = 500;
        // 设置定位精度 （精确度越高，越耗电，所以需要我们根据实际情况，设定对应的精度）
        _locationM.desiredAccuracy = kCLLocationAccuracyBest;


        /** ------适配iOS8.0------- */

        // 判断系统版本
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
/**
 *  注意：如果两个授权都请求，那么先执行前面那个请求弹框，后面那个请求授权 有可能 下次被调用时，才会起作用
 *  如果，先请求的是“前后台授权”，那“前台授权”即使被调用，也不会有反应（因为“前后台授权”权限大于“前台授权”）
 *  反之，如果先请求的是“前台授权”，而且用户选中的是“允许”，那下次被调用时“前后台授权”会做出请求，但只请求一次
 *
 *  本质：1. 两个授权同时请求，先执行前面那个授权请求
 *       2. “前后台请求授权”方法，在（当前的授权状态 == 用户未选择状态 / 前台授权状态） 才会起作用
 *       3. “前台请求授权”方法，在（当前的授权状态 == 用户未选择状态） 才会起作用
 */

            // 请求前台的授权(默认当App进入前台后可以定位，后台不可定位)
            // 当后台模式添加location后，即使后台也可以获取用户位置，但会出现蓝条
//            [_locationM requestWhenInUseAuthorization];
            // 请求前后台的授权（前后台都可以获取用户位置，而且不会出现蓝条）
            [_locationM requestAlwaysAuthorization];
        }

        // 另外一种适配不同版本API的方法
//        if ([_locationM respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//
//            [_locationM requestAlwaysAuthorization];
//            [_locationM requestWhenInUseAuthorization];
//        }

    }
    return _locationM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}



- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{

    // 2.使用位置管理器进行定位
    if([CLLocationManager locationServicesEnabled])
    {
        [self.locationM startUpdatingLocation];
    }else
    {
        NSLog(@"不能定位呀");
    }

}


#pragma mark -CLLocationManagerDelegate

/**
 *  当用户授权状态发生变化时调用
 */
-(void)locationManager:(nonnull CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            break;
        }
            // 问受限
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
            // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启，但被拒");
            }else
            {
                NSLog(@"定位关闭，不可用");
            }
            break;
        }
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
//        case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
        {
            NSLog(@"获取前后台定位授权");
            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台定位授权");
            break;
        }
        default:
            break;
    }

}

/**
 * 当位置管理器，获取到位置后，就会调用这样的方法
 */
-(void)locationManager:(nonnull CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    NSLog(@"已经定位到了！");
}


@end
