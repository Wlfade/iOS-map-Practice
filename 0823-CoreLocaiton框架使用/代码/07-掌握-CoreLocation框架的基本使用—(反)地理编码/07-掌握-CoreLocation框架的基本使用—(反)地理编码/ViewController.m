//
//  ViewController.m
//  07-掌握-CoreLocation框架的基本使用—(反)地理编码
//
//  Created by xiaomage on 15/8/23.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *addressTV;
@property (weak, nonatomic) IBOutlet UITextField *laTF;
@property (weak, nonatomic) IBOutlet UITextField *longTF;


/** 地理编码 */
@property (nonatomic, strong) CLGeocoder *geoC;


@end

@implementation ViewController

- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}

- (IBAction)geoCoder {
    
    
    NSString *addr  = self.addressTV.text;
    
    if ([addr length] == 0) {
        return;
    }
    
    [self.geoC geocodeAddressString:@"小码哥" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        /**
         *  CLPlacemark
         location : 位置对象
         addressDictionary : 地址字典
         name : 地址全称
         */

        if(error == nil)
        {
            NSLog(@"%@", placemarks);
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@", obj.name);
                self.addressTV.text = obj.name;
                self.laTF.text = @(obj.location.coordinate.latitude).stringValue;
                self.longTF.text = @(obj.location.coordinate.longitude).stringValue;
            }];
        }else
        {
            NSLog(@"cuowu--%@", error.localizedDescription);
        }
   
    }];
    
}
- (IBAction)reverseGeoCoder {
    
    
    double lati = [self.laTF.text doubleValue];
    double longi = [self.longTF.text doubleValue];
    
    // TODO: 容错
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:lati longitude:longi];
    [self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error == nil)
        {
            NSLog(@"%@", placemarks);
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@", obj.name);
                self.addressTV.text = obj.name;
                self.laTF.text = @(obj.location.coordinate.latitude).stringValue;
                self.longTF.text = @(obj.location.coordinate.longitude).stringValue;
            }];
        }else
        {
            NSLog(@"cuowu");
        }
        
    }];
    
    
    
}



@end
