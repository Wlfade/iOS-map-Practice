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
@interface ViewController ()<MKMapViewDelegate>
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
    self.mapView.showsUserLocation = YES;
    
//    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
}

#pragma mark - MKMapViewDelegate
/**
 *  更新到位置
 *
 *  @param mapView      地图
 *  @param userLocation 位置对象
 */
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    /**
     *  MKUserLocation (大头针模型)
     *
     
     *
     */
    userLocation.title = @"小码哥";
    userLocation.subtitle = @"大神一班";
    
    
    // 设置地图显示中心
//    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    
    // 设置地图显示区域
    MKCoordinateSpan span = MKCoordinateSpanMake(0.051109, 0.034153);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    
    
}

//-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
//{
//    NSLog(@"%f----%f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
//}





@end
