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

/** 反地理编码 */
@property(nonatomic,strong)CLGeocoder *geoC;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

/** 反地理编码 */
-(CLGeocoder *)geoC{
    if (_geoC == nil) {
        _geoC = [[CLGeocoder alloc]init];
    }
    return _geoC;
}

/*
 1.可以将需要导航的位置丢给系统的地图app进行导航
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //补充1
    // 3D视角
//    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:CLLocationCoordinate2DMake(23.132931, 113.375924) fromEyeCoordinate:CLLocationCoordinate2DMake(23.135931, 113.375924) eyeAltitude:100];
//    self.mapView.camera = camera;

    //补充2
//    //地图屏幕快照截图
//    MKMapSnapshotOptions *option = [[MKMapSnapshotOptions alloc]init];
//
//    //针对地图
//    option.region = self.mapView.region;
//    option.showsBuildings = YES;
//
//    //输出图片
//    option.size = CGSizeMake(1000, 2000);
//    option.scale = [UIScreen mainScreen].scale;
//
//    MKMapSnapshotter *snap = [[MKMapSnapshotter alloc]initWithOptions:option];
//
//    [snap startWithCompletionHandler:^(MKMapSnapshot * _Nullable snapshot, NSError * _Nullable error) {
//
//        if (error == nil) {
//            UIImage *image = snapshot.image;
//
//            NSData *data = UIImagePNGRepresentation(image);
//
//            [data writeToFile:@"/Users/danche/Desktop/map.png" atomically:YES];
//        }else{
//            NSLog(@"--%@",error.localizedDescription);
//        }
//
//    }];
    
}

- (void)beginNav{
    [self.geoC geocodeAddressString:@"广州" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *gzP = [placemarks firstObject];
        
        [self.geoC geocodeAddressString:@"上海" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *shP = [placemarks firstObject];
            
            [self systemNavigation:gzP andEndP:shP];
        }];
        
    }];
}
- (void)systemNavigation:(CLPlacemark *)beginP andEndP:(CLPlacemark *)endP{
    //创建开始的地图项
    CLPlacemark *clpB = beginP;
    MKPlacemark *mkPB = [[MKPlacemark alloc]initWithPlacemark:clpB];
    MKMapItem *beginI = [[MKMapItem alloc]initWithPlacemark:mkPB];
    
    //创建结束的地图项
    CLPlacemark *clpE = endP;
    MKPlacemark *mkPE = [[MKPlacemark alloc]initWithPlacemark:clpE];
    MKMapItem *endI = [[MKMapItem alloc]initWithPlacemark:mkPE];
    
    
    //地图项数组
    NSArray *items = @[beginI,endI];
    
    NSDictionary *dic = @{
                          //导航方式
                          MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                          //地图类型
                          MKLaunchOptionsMapTypeKey:@(MKMapTypeHybrid),
                          //是否显示交通
                          MKLaunchOptionsShowsTrafficKey:@(YES)
                          };
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}
@end
