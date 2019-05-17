//
//  ViewController.m
//  08-掌握-CoreLocation框架的基本使用—定位的第三方框架
//
//  Created by xiaomage on 15/8/23.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "INTULocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
//    INTULocationRequestID requestID =  [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
//                                       timeout:5.0
//                          delayUntilAuthorized:YES
//                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
//                                             if (status == INTULocationStatusSuccess) {
//                                                 NSLog(@"%@", currentLocation);
//                                             }
//                                             else
//                                             {
//                                                 NSLog(@"cuowu--%zd", status);
//                                             }
//                                         }];
//    
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    INTULocationRequestID requestID =  [locMgr subscribeToLocationUpdatesWithBlock:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            NSLog(@"%@", currentLocation);
        }
        else
        {
            NSLog(@"cuowu--%zd", status);
        }
    }];
    
    
    // Force the request to complete early, like a manual timeout (will execute the block)
//    [[INTULocationManager sharedInstance] forceCompleteLocationRequest:requestID];
    
    // Cancel the request (won't execute the block)
//    [[INTULocationManager sharedInstance] cancelLocationRequest:requestID];


}

@end
