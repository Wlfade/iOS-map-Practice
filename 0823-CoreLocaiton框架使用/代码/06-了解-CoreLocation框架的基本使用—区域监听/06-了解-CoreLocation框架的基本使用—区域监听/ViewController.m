//
//  ViewController.m
//  06-了解-CoreLocation框架的基本使用—区域监听
//
//  Created by xiaomage on 15/8/23.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>

/**  位置管理者 */
@property (nonatomic, strong) CLLocationManager *lM;

@end

@implementation ViewController

- (CLLocationManager *)lM
{
    if (!_lM) {
        _lM = [[CLLocationManager alloc] init];
        _lM.delegate = self;
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
            [_lM requestAlwaysAuthorization];
        }
        
        
    }
    return _lM;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    // 区域监听
    
    CLLocationCoordinate2D center = {21.13, 123.456};
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:1000 identifier:@"小码哥"];
    
//    [self.lM startMonitoringForRegion:region];
    
//    CLLocationCoordinate2D center2 = {21.13, 123.456};
//    CLCircularRegion *region2 = [[CLCircularRegion alloc] initWithCenter:center2 radius:1000 identifier:@"小码哥2"];
//    
//    [self.lM startMonitoringForRegion:region2];

    // 请求区域状态
    [self.lM requestStateForRegion:region];

}


#pragma mark - CLLocationManagerDelegate
// 进入区域
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"进入区域--%@", region.identifier);
}

// 离开区域
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"离开区域--%@", region.identifier);
}


-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSLog(@"%zd", state);
    
    
}



@end
