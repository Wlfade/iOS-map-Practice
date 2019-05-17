//
//  ViewController.m
//  05-了解-CoreLocation框架的基本使用——指南针
//
//  Created by xiaomage on 15/8/23.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()<CLLocationManagerDelegate>

/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *lM;

@property (weak, nonatomic) IBOutlet UIImageView *compassView;



@end

@implementation ViewController


- (CLLocationManager *)lM
{
    if (!_lM) {
        _lM = [[CLLocationManager alloc] init];
        _lM.delegate = self;
        
        // 每隔多少度更新一次
        _lM.headingFilter = 2;
        
    }
    return _lM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // 开始监听设备朝向
    [self.lM startUpdatingHeading];
    
}


#pragma mark - CLLocationManagerDelegate
/**
 *  获取到手机朝向时调用
 *
 *  @param manager    位置管理者
 *  @param newHeading 朝向对象
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    /**
     *  CLHeading 
     *  magneticHeading : 磁北角度
     *  trueHeading : 真北角度
     */
    
    NSLog(@"%f", newHeading.magneticHeading);
    
    CGFloat angle = newHeading.magneticHeading;
    
    // 把角度转弧度
    CGFloat angleR = angle / 180.0 * M_PI;
    
    // 旋转图片
    [UIView animateWithDuration:0.25 animations:^{
        self.compassView.transform = CGAffineTransformMakeRotation(-angleR);
    }];
    
    
}



@end
