//
//  ViewController.m
//  08-掌握-CoreLocation框架的基本使用—定位的第三方框架
//
//  Created by 王顺子 on 15/8/6.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "INTULocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{

    /** 使用注意：如果是iOS8+，记得设置info.plist文件中 NSLocationWhenInUseUsageDescription 或者 NSLocationAlwaysUsageDescription */

    /**
     *  设置定位精度和超时时常进行定位，定位完成后通过block回调通知开发者
     */
//    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyRoom timeout:10 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
//        if (status == INTULocationStatusSuccess) {
//            NSLog(@"%@", currentLocation);
//        }else
//        {
//            NSLog(@"定位失败");
//        }
//
//    }];
    /**
     *  设置定位精度和超时时常进行定位，定位完成后通过block回调通知开发者,
     *  注意：delayUntilAuthorized 值作用是：超时时常是从什么时候开始计算（用户授权后开始计算==YES, 调用此方法开始计算==NO）
     */
  INTULocationRequestID requestID = [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyRoom timeout:10 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            NSLog(@"%@", currentLocation);
        }else
        {
            NSLog(@"定位失败");
        }
    }];

    /** 可以根据位置请求ID，强制结束一个位置请求，或者取消位置请求 */
    // 强制完成位置请求（会调用回调block）
//    [[INTULocationManager sharedInstance] forceCompleteLocationRequest:requestID];
    // 取消位置请求（不会调用回调block）
    [[INTULocationManager sharedInstance] cancelLocationRequest:requestID];

}

@end
