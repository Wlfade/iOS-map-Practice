//
//  ThirdFrameViewController.m
//  01-掌握-CoreLocation框架的基本使用—定位（iOS8.0-）
//
//  Created by 单车 on 2019/4/15.
//  Copyright © 2019 小码哥. All rights reserved.
//

#import "ThirdFrameViewController.h"
#import "INTULocationManager.h"

@interface ThirdFrameViewController ()
{
    NSString *_name; //成员变量
}
/**名称 */
@property(nonatomic,strong)NSString *name;
@end

@implementation ThirdFrameViewController

/**
 1.防止对象被提前创建
 2.防止对象重复创建
 3.防止对象使用时，还没有被创建
 4.可以在懒加载方法里面，进行初始化操作
*/
/** 名称 */
-(NSString *)name{
    if (_name == nil) {
        _name = @"123";
    }
    return _name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    INTULocationRequestID requestId = [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                       timeout:10.0
                          delayUntilAuthorized:YES    // This parameter is optional, defaults to NO if omitted
                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                             if (status == INTULocationStatusSuccess) {
                                                 NSLog(@"位置：%@",currentLocation);
                                             }
                                             else if (status == INTULocationStatusTimedOut) {
                                                 NSLog(@"超时");                                   }
                                             else {
                                                 NSLog(@"出错");
                                             }
                                         }];
    
    //描述 持续定位
//    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
//
//    INTULocationRequestID requestId = [locMgr subscribeToLocationUpdatesWithBlock:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
//        if (status == INTULocationStatusSuccess) {
//            NSLog(@"位置：%@",currentLocation);
//        }
//        else if (status == INTULocationStatusTimedOut) {
//            NSLog(@"超时");
//        }
//        else {
//            NSLog(@"出错");
//        }
//    }];
    
    //完成
//    [[INTULocationManager sharedInstance] forceCompleteLocationRequest:requestId];
    
    //取消
    [[INTULocationManager sharedInstance] cancelLocationRequest:requestId];

}
@end
