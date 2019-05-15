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

#import "XMGAnno.h"

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

/** 地理编码 */
@property(nonatomic,strong)CLGeocoder *geoc;

@end

@implementation ViewController

/** 地理 */
-(CLGeocoder *)geoc{
    if (_geoc == nil) {
        _geoc = [[CLGeocoder alloc]init];
    }
    return _geoc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //1.获取当前触摸点
    CGPoint point = [[touches anyObject]locationInView:self.mapView];
    
    //2.转换成经纬度
    CLLocationCoordinate2D pt = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    //3.添加大头针
    [self addAnnoWithPT:pt];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *annos = self.mapView.annotations;
    [self.mapView removeAnnotations:annos];
}
/**
 添加大头针
 @param pt 经纬度位置
 */
- (void)addAnnoWithPT:(CLLocationCoordinate2D)pt{
    __block XMGAnno *anno = [[XMGAnno alloc]init];
    anno.coordinate = pt;
    anno.title = @"title";
    anno.subtitle = @"subTitle";
    //地图上加上大头针视图
    [self.mapView addAnnotation:anno];
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:anno.coordinate.latitude longitude:anno.coordinate.longitude];
    [self.geoc reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *mark = [placemarks firstObject];
        anno.title = mark.locality;
        anno.subtitle = mark.thoroughfare;
    }];
}
#pragma mark - MKMapViewDelegate

/**
 更新到位置

 @param mapView 地图
 @param userLocation 位置对象
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
 
    
}

/**
 当添加大头针模型时

 @param mapView 地图
 @param annotation 大头针
 @return 大头针视图
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    return nil;
}
@end
