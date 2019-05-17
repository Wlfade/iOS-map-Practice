//
//  ViewController.m
//  07-掌握-CoreLocation框架的基本使用—（反）地理编码
//
//  Created by 王顺子 on 15/8/5.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
@interface ViewController ()

// 地址详情TextView
@property (weak, nonatomic) IBOutlet UITextView *addressDetailTV;

// 纬度TextField
@property (weak, nonatomic) IBOutlet UITextField *latitudeTF;

// 经度度TextField
@property (weak, nonatomic) IBOutlet UITextField *longtitudeTF;

// 用作地理编码、反地理编码的工具类
@property (nonatomic, strong) CLGeocoder *geoC;

@end

@implementation ViewController

#pragma mark - 懒加载
-(CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}

// 地理编码
- (IBAction)geoCoder {

    if ([self.addressDetailTV.text length] == 0) {
        return;
    }

    // 地理编码方案一：直接根据地址进行地理编码（返回结果可能有多个，因为一个地点有重名）
    [self.geoC geocodeAddressString:self.addressDetailTV.text completionHandler:^(NSArray<CLPlacemark *> * __nullable placemarks, NSError * __nullable error) {
        // 包含区，街道等信息的地标对象
        CLPlacemark *placemark = [placemarks firstObject];
        // 城市名称
//        NSString *city = placemark.locality;
        // 街道名称
//        NSString *street = placemark.thoroughfare;
        // 全称
        NSString *name = placemark.name;
        self.addressDetailTV.text = [NSString stringWithFormat:@"%@", name];
        self.latitudeTF.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.latitude];
        self.longtitudeTF.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.longitude];
    }];



    // 地理编码方案二：根据地址和区域两个条件进行地理编码（更加精确）
//    [self.geoC geocodeAddressString:self.addressDetailTV.text inRegion:nil completionHandler:^(NSArray<CLPlacemark *> * __nullable placemarks, NSError * __nullable error) {
//        // 包含区，街道等信息的地标对象
//        CLPlacemark *placemark = [placemarks firstObject];
//        self.addressDetailTV.text = placemark.description;
//        self.latitudeTF.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.latitude];
//        self.longtitudeTF.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.longitude];
//    }];

    

    // 地理编码方案三：
//    NSDictionary *addressDic = @{
//                                 (__bridge NSString *)kABPersonAddressCityKey : @"北京",
//                                 (__bridge NSString *)kABPersonAddressStreetKey : @"棠下街"
//                                 };
//    [self.geoC geocodeAddressDictionary:addressDic completionHandler:^(NSArray<CLPlacemark *> * __nullable placemarks, NSError * __nullable error) {
//        CLPlacemark *placemark = [placemarks firstObject];
//        self.addressDetailTV.text = placemark.description;
//        self.latitudeTF.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.latitude];
//        self.longtitudeTF.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.longitude];
//    }];




}

// 反地理编码
- (IBAction)decode {
    // 过滤空数据
    if ([self.latitudeTF.text length] == 0 || [self.longtitudeTF.text length] == 0) {
        return;
    }
    // 创建CLLocation对象
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.latitudeTF.text doubleValue] longitude:[self.longtitudeTF.text doubleValue]];
    // 根据CLLocation对象进行反地理编码
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * __nullable placemarks, NSError * __nullable error) {
        // 包含区，街道等信息的地标对象
        CLPlacemark *placemark = [placemarks firstObject];
        // 城市名称
//        NSString *city = placemark.locality;
        // 街道名称
//        NSString *street = placemark.thoroughfare;
        // 全称
        NSString *name = placemark.name;
        self.addressDetailTV.text = [NSString stringWithFormat:@"%@", name];
    }];

}

@end
