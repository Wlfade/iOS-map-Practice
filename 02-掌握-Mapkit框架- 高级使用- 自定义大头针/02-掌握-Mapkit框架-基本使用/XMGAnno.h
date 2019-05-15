//
//  XMGAnno.h
//  02-掌握-Mapkit框架-基本使用
//
//  Created by 单车 on 2019/4/15.
//  Copyright © 2019 单车. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMGAnno : NSObject <MKAnnotation>
// Center latitude and longitude of the annotation view.
// The implementation of this property must be KVO compliant.
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

//数据类型
@property (nonatomic,assign) NSInteger annoType;

@end

NS_ASSUME_NONNULL_END
