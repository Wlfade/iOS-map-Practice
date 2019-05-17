//
//  ViewController.m
//  01-掌握-MapKit框架-基本使用
//
//  Created by xiaomage on 15/8/23.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


/**   */
@property (nonatomic, strong) CLLocationManager *lM;

@end

@implementation ViewController


- (CLLocationManager *)lM
{
    if (!_lM) {
        _lM = [[CLLocationManager alloc] init];
        if ([_lM respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_lM requestAlwaysAuthorization];
        }
    }
    return _lM;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /**
     MKMapTypeStandard = 0,
     MKMapTypeSatellite,
     MKMapTypeHybrid,
     MKMapTypeSatelliteFlyover NS_ENUM_AVAILABLE(10_11, 9_0),
     MKMapTypeHybridFlyover NS_ENUM_AVAILABLE(10_11, 9_0),
     */
//    self.mapView.mapType = MKMapTypeSatelliteFlyover;
    
    
//    self.mapView.zoomEnabled = NO;
//    
////    self.mapView.showsCompass = NO;
//    self.mapView.showsScale = YES;
    
    [self lM];
//    self.mapView.showsUserLocation = YES;
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    
}

@end
