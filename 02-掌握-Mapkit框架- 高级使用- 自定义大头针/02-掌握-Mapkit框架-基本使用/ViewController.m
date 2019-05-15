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


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.获取当前触摸点
    CGPoint point = [[touches anyObject]locationInView:self.mapView];

    //2.转换成经纬度
    CLLocationCoordinate2D pt = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];

    //3.添加大头针
    [self addAnnoWithPT:pt];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //移除大头针视图
//    NSArray *annos = self.mapView.annotations;
//    [self.mapView removeAnnotations:annos];
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
    anno.annoType = arc4random_uniform(5);
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
    static NSString *inden = @"datouzhen";
    
    MKAnnotationView *pin = [mapView dequeueReusableAnnotationViewWithIdentifier:inden];
    if (pin == nil) {
        pin = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:inden];
    }
    
    pin.annotation = annotation;
    
    // 设置是否弹出标注
    pin.canShowCallout = YES;
    
    XMGAnno *anno = (XMGAnno *)annotation;
    
    NSString *imageName = [NSString stringWithFormat:@"category_%zd",anno.annoType+1];
    
    pin.image = [UIImage imageNamed:imageName];
    //可拖拽
    pin.draggable = YES;
    
    //设置的标注偏移量
//    pin.calloutOffset = CGPointMake(5, 8);
    
    
    UIImageView *liv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    liv.image = [UIImage imageNamed:@"eason"];
    //标签的左侧图片
    pin.leftCalloutAccessoryView = liv;
    
    
    UIImageView *riv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    riv.image = [UIImage imageNamed:@"htl"];
    pin.rightCalloutAccessoryView = riv;
    
//    UIImageView *div = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    div.image = [UIImage imageNamed:@"huba"];
    //标注详情的视图
    pin.detailCalloutAccessoryView = [UISwitch new];
    
    return pin;

}


/**
 返回系统的大头针视图

 @param mapView 地图
 @param annotation 大头针数据模型
 @return 大头针视图
 */
- (MKPinAnnotationView *)systemmapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *inden = @"datouzhen";
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:inden];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:inden];
    }
    
    pin.annotation = annotation;
    
    // 设置是否弹出标注
    pin.canShowCallout = YES;
    
    // 设置大头针颜色
    pin.pinTintColor = [UIColor cyanColor];
    
    //从天而降动画
    pin.animatesDrop = YES;
    
    //设置大头针图片（系统无效）
    //    pin.image = [UIImage imageNamed:@"category_5"];
    //可拖拽
    pin.draggable = YES;
    
    return pin;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(nonnull MKAnnotationView *)view{
    NSLog(@"选中");
    
    NSLog(@"%@",view.annotation);
    
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(nonnull MKAnnotationView *)view{
    NSLog(@"不选中");
    NSLog(@"%@",view.annotation);
}
@end
