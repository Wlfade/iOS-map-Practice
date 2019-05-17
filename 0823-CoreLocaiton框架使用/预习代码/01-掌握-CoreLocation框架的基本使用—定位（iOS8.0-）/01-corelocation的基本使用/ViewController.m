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
/** 懒加载的好处
 *  1. 防止对象提前创建，占用内存空间
 *  2. 防止使用的时候，还没有被创建
 *  3. 防止被重复创建
 *  4. 可以在懒加载方法里面进行初始化设置
 */
- (CLLocationManager *)locationM
{
    if (!_locationM) {
        // 创建位置管理器
        _locationM = [[CLLocationManager alloc] init];
        // 设置代理
        _locationM.delegate = self;

        
        /** ------附加设置------- */
        // 设置定位距离过滤参数 （当上次定位和本次定位之间的距离 >= 此值时，才会调用代理通知开发者）
        _locationM.distanceFilter = 500;
        // 设置定位精度 （精确度越高，越耗电，所以需要我们根据实际情况，设定对应的精度）
        _locationM.desiredAccuracy = kCLLocationAccuracyBest;
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
 * 当位置管理器，获取到位置后，就会调用这样的方法
 */
-(void)locationManager:(nonnull CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    NSLog(@"已经定位到了！");
    // 定位到之后，可以调用此方法停止更新位置
    [self.locationM stopUpdatingLocation];
}


@end
