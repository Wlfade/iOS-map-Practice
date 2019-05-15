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
{
    CLLocation *_oldLocation; //老位置
}

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

        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //前台(默认情况下，不可以在后台获取位置，勾选后台模式 location update，但是会出现蓝条 )
            [_lM requestWhenInUseAuthorization];
            
            //(9.0)后需要调用的方法 运行后台获取用户位置(必须勾选后台 否则崩溃)
            _lM.allowsBackgroundLocationUpdates = YES;

            //前后台
//            [_lM requestAlwaysAuthorization];
        }
    }
    return _lM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self.lM startUpdatingLocation];
    
    
//    CLLocation *l1 = [[CLLocation alloc]initWithLatitude:21.123 longitude:123.245];
//
//    CLLocation *l2 = [[CLLocation alloc]initWithLatitude:22.123 longitude:124.245];
//
//    CLLocationDistance distance = [l1 distanceFromLocation:l2];
//
//    NSLog(@"%f",distance);
    
    
    

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
//    NSLog(@"定位到了");
    CLLocation *location = [locations lastObject];
    //<+37.78583400,-122.40641700> +/- 5.00m (speed -1.00 mps / course -1.00) @ 4/12/19, 7:10:03 AM GMT
    /*
     CLLocation
     - coordinate
        CLLocationDegrees latitude;  //维度
        CLLocationDegrees longitude; //经度
     - altitude 海拔
     - course 航向
     - floor 楼层
     - description 描述
     - speed 速度

     */
    NSLog(@"%@",location);
    /*
     场景演示：打印当前用户的行走方向，偏离角度以及对应的行走距离
     例如：“北偏东 30度  方向， 移动了8米”
     */
    
    //1.获取方向偏向
    NSString *angleStr = nil;
    switch ((int)location.course / 90) {
        case 0:
            angleStr = @"北偏东";
            break;
        case 1:
            angleStr = @"东偏南";
            break;
        case 2:
            angleStr = @"南偏西";
            break;
        case 3:
            angleStr = @"西偏北";
            break;
        default:
            angleStr = @"空";
            break;
    }
    
    //2.获取角度 取余
    NSInteger angle = 0;
    angle = (int)location.course % 90;
    
    if (angle == 0) {
        NSRange range = NSMakeRange(0, 1);
        angleStr = [NSString stringWithFormat:@"正%@",[angleStr substringWithRange:range]];
    }
    
    //3.移动多少米
    double distance = 0;
    if (_oldLocation) {
        distance = [location distanceFromLocation:_oldLocation];
    }
    
    //4.拼串打印
    NSString *noticeStr = [NSString stringWithFormat:@"%@--%zd 方向，移动了%f米",angleStr,angle,distance];
    
    NSLog(@"%@",noticeStr);
    
    _oldLocation = location;
    
}

/**
 *  授权状态发生改变时调用
 *
 *  @param manager 位置管理者
 *  @param status  状态
 */
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
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
            //            NSLog(@"被拒");
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

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
}
@end
