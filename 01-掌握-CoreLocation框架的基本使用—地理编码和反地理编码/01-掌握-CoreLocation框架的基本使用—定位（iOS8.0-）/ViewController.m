//
//  ViewController.m
//  01-掌握-CoreLocation框架的基本使用—定位（iOS8.0-）
//
//  Created by xiaomage on 15/8/23.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *addressTV;
@property (weak, nonatomic) IBOutlet UITextField *laTF;
@property (weak, nonatomic) IBOutlet UITextField *longTF;

@property(nonatomic,strong)CLGeocoder *geoC;


@end

@implementation ViewController

/** 地理编码管理 */
- (CLGeocoder *)geoC{
    if (_geoC == nil) {
        _geoC = [[CLGeocoder alloc]init];
    }
    return _geoC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

}
//地理编码
- (IBAction)geoCode {
    
    NSString *addStr = self.addressTV.text;
    
    if ([addStr length] == 0) {
        return;
    }
    
    [self.geoC geocodeAddressString:addStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        /**
         CLPlacemark
         location : 位置对象
         addressDictionary : 地址字典
            name: 地址全称
         
         
         */
        if (error == nil) {
//            NSLog(@"%@",placemarks);
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@",obj.name);
                self.addressTV.text = obj.name;
                self.laTF.text = @(obj.location.coordinate.latitude).stringValue;
                self.longTF.text = @(obj.location.coordinate.longitude).stringValue;
            }];
        }else{
            NSLog(@"出错");
        }
    }];
}
//反地理编码
- (IBAction)reverseGeoCode {
    
//    CLLocation *loc = [[CLLocation alloc]initWithLatitude:30.212411 longitude:120.212638];
    
    double lati = [self.laTF.text doubleValue];
    double longi = [self.longTF.text doubleValue];
    
    //获取地理坐标可使用百度地图，地图开发平台->开发文档->工具支持器->坐标拾取器。
    
    // TODO : 容错
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:lati longitude:longi];

    
    [self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil) {
            //            NSLog(@"%@",placemarks);
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@",obj.name);
                self.addressTV.text = obj.name;
                self.laTF.text = @(obj.location.coordinate.latitude).stringValue;
                self.longTF.text = @(obj.location.coordinate.longitude).stringValue;
            }];
        }else{
            NSLog(@"出错");
        }
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
