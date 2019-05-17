//
//  ViewController.m
//  05-了解-CoreLocation框架的基本使用—指南针
//
//  Created by 王顺子 on 15/8/5.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *compassView;

@property (nonatomic, strong) CLLocationManager *locationM;

@end


@implementation ViewController


#pragma mark - 懒加载
-(CLLocationManager *)locationM
{
    if (!_locationM) {
        /**
         *  注意：获取手机设备朝向，不需要用户授权
         */
        _locationM = [[CLLocationManager alloc] init];
        _locationM.delegate = self;
    }
    return _locationM;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    if ([CLLocationManager headingAvailable]) {
        // 开始监听设备朝向
        [self.locationM startUpdatingHeading];
    }

}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(nonnull CLLocationManager *)manager didUpdateHeading:(nonnull CLHeading *)newHeading
{
    // 获取当前设备朝向(磁北方向)
    CGFloat angle = newHeading.magneticHeading;

    // 转换成为弧度
    CGFloat radian = angle / 180.0 * M_PI;

    // 反向旋转指南针
    [UIView animateWithDuration:0.5 animations:^{
        self.compassView.transform = CGAffineTransformMakeRotation(-radian);
    }];
}



@end
