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

// 位置管理器
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

        // 判断系统版本,请求前台授权
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            // 在iOS9.0+（如果当前授权状态是使用时授权，那么App退到后台后，将不能获取用户位置，即使勾选后台模式：location）
            [_locationM requestWhenInUseAuthorization];
        }
        // 要想继续获取位置，需要使用以下属性进行设置（注意勾选后台模式：location）但会出现蓝条
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            _locationM.allowsBackgroundLocationUpdates = YES;
        }

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
//        [self.locationM startUpdatingLocation];
        // 作用：按照定位精确度从低到高进行排序，逐个进行定位。如果获取到的位置不是精确度最高的那个，也会在定位超时后，通过代理告诉外界
        // 注意：一个要实现代理的定位失败方法； 二：不能与startUpdatingLocation同时使用
        [self.locationM requestLocation];
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
    NSLog(@"已经定位到了！--%@", locations);
   
}

/**
 * 当定位失败后调用此方法
 */
-(void)locationManager:(nonnull CLLocationManager *)manager didFailWithError:(nonnull NSError *)error
{

    NSLog(@"定位失败--%@", error.localizedDescription);
}

@end
