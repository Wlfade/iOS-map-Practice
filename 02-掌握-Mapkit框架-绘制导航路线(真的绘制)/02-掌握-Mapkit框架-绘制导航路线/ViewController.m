//
//  ViewController.m
//  02-掌握-Mapkit框架-绘制导航路线
//
//  Created by 王玲峰 on 5/3/19.
//  Copyright © 2019 王玲峰. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<MKMapViewDelegate>

/** 地理编码 */
@property (nonatomic,strong)CLGeocoder *geoC;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (CLGeocoder *)geoC{
    if (_geoC == nil) {
        _geoC = [[CLGeocoder alloc]init];
    }
    return _geoC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.geoC geocodeAddressString:@"广州" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *gzP = [placemarks firstObject];
        [self.geoC geocodeAddressString:@"上海" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *shP = [placemarks firstObject];
            [self getRouteWithBeginPL:gzP andEndPL:shP];
        }];
        
    }];
    
}
- (void)getRouteWithBeginPL:(CLPlacemark *)beginPL andEndPL:(CLPlacemark *)endPL{
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:beginPL.location.coordinate radius:10000];
    [self.mapView addOverlay:circle];
    
    MKCircle *circle2 = [MKCircle circleWithCenterCoordinate:endPL.location.coordinate radius:10000];
    [self.mapView addOverlay:circle2];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    
    CLPlacemark *souceCP = beginPL;
    MKPlacemark *souceMark = [[MKPlacemark alloc]initWithPlacemark:souceCP];
    MKMapItem *sourceItem = [[MKMapItem alloc]initWithPlacemark:souceMark];
    //起点
    request.source = sourceItem;
    
    CLPlacemark *endCP = endPL;
    MKPlacemark *endMark = [[MKPlacemark alloc]initWithPlacemark:endCP];
    MKMapItem *endItem = [[MKMapItem alloc]initWithPlacemark:endMark];
    
    //终点
    request.destination = endItem;
    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        /*
         MKDirectionsResponse
         routes : 路线数组MKRoute
         expectedTravelTime : 预期时间
         polyLine : 折线（数据模型）
         */
        /*
          MKRoute
            name : 路线名称
            distance: 距离
         steps
         */
        /*
         steps MKRouteStep
         instructions : 行走提示
         */
        [response.routes enumerateObjectsUsingBlock:^(MKRoute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"路线名：%@  期望时间：%f  距离：%f",obj.name,obj.expectedTravelTime,obj.distance);
            MKPolyline *polyline = obj.polyline;
            //添加覆盖层
            [self.mapView addOverlay:polyline];

        }];
    }];
}
#pragma mark -MKMapViewDelegate

/**
 获取对应的图层渲染

 @param mapView 地图
 @param overlay 覆盖层数据模型
 @return 图层
 */
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    
    
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer *circle = [[MKCircleRenderer alloc]initWithOverlay:overlay];
        circle.fillColor = [UIColor yellowColor];
        return circle;

    }else if ([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer *rander = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        rander.lineWidth = 5;
        rander.strokeColor = [UIColor redColor];
        return rander;

    }
    return nil;
}


@end
