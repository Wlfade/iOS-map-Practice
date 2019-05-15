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
@interface ViewController ()<CLLocationManagerDelegate>
/*
 MKMapView 的 mapType 设置地图类型
 MKMapTypeStandard : 普通地图
 MKMapTypeSatellite : 卫星云图
 MKMapTypeHybrid : 混合模式
 MKMapTypeSatelliteFlyover : 3D立体卫星 （iOS 9.0）
 MKMapTypeHybridFlyover : 3D立体混合 （iOS 9.0）
 */
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


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
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
}

@end
