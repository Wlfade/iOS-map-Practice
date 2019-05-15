//
//  ViewController.m
//  02-掌握-Mapkit框架-基本使用
//
//  Created by 单车 on 2019/4/15.
//  Copyright © 2019 单车. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<MKMapViewDelegate>
/*
 MKMapView 的 mapType 设置地图类型
 MKMapTypeStandard : 普通地图
 MKMapTypeSatellite : 卫星云图
 MKMapTypeHybrid : 混合模式
 MKMapTypeSatelliteFlyover : 3D立体卫星 （iOS 9.0）
 MKMapTypeHybridFlyover : 3D立体混合 （iOS 9.0）
 */
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

/*
 资源库->Developer->CoreSimulator->Profiles->Runtimes (存放了其他版本的Xcode模拟器)
 */
/** 位置管理 */
@property(nonatomic,strong)CLLocationManager *lm;
@end

@implementation ViewController

/** 位置管理 */
-(CLLocationManager *)lm{
    if (_lm == nil) {
        _lm = [[CLLocationManager alloc]init];
        
//        [_lm requestAlwaysAuthorization];
        
        
        [_lm requestWhenInUseAuthorization];
        
        //(9.0)后需要调用的方法 运行后台获取用户位置(必须勾选后台 否则崩溃)
        _lm.allowsBackgroundLocationUpdates = YES;
    }
    return _lm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    MKMapView *mapView = [MKMapView new];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self lm];
    
//    self.mapView.mapType = MKMapTypeSatelliteFlyover;
    
    //是否可以缩放
//    self.mapView.zoomEnabled = NO;
    
    //指南针
    self.mapView.showsCompass = YES;
    //比例尺
    self.mapView.showsScale = YES;
    //用户定位 （需要使用 CLLocationManager）
    self.mapView.showsUserLocation = YES;
    //用户追踪模式
//    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
}

#pragma mark - MKMapViewDelegate

/**
 更新到位置

 @param mapView 地图
 @param userLocation 位置对象
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    /**
     MKUserLocation 大头针模型
     
     */
    userLocation.title = @"title";
    userLocation.subtitle = @"subtitle";
    
    // 设置地图显示中心
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    // 设置地图显示跨度 经纬度 越小越精确
    MKCoordinateSpan span = MKCoordinateSpanMake(0.001592, 0.003103);
    // 设置地图显示区域
    MKCoordinateRegion regin = MKCoordinateRegionMake(userLocation.location.coordinate, span);

    [self.mapView setRegion:regin animated:YES];
    
}
//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    NSLog(@"%f---%f",mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
//}
@end
