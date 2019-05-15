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

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


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
        
        //每隔多少度更新一次
        _lM.headingFilter = 2;
        
        _lM.delegate = self;
    }
    return _lM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //开始监听设备朝向
    [self.lM startUpdatingHeading];
}

#pragma mark CLLocationManagerDelegate

/**
 监听设备朝向的代理

 @param manager 设备
 @param newHeading 朝向
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    /**
     *  CLHeading
     *  magneticHeading 磁北
     *  trueHeading 真北
     
    */
    NSLog(@"%.f",newHeading.magneticHeading);
    
    //把角度转换成弧度
    CGFloat angle = newHeading.magneticHeading;
    
    CGFloat anleR = angle / 180 * M_PI;
    
    //旋转图片
    [UIView animateWithDuration:0.3 animations:^{
        self.bgImageView.transform = CGAffineTransformMakeRotation(-anleR);
    }];
    
    
}


@end
