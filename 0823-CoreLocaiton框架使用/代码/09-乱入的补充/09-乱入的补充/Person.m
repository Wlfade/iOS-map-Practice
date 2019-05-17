//
//  Person.m
//  09-乱入的补充
//
//  Created by xiaomage on 15/8/23.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "Person.h"

@implementation Person



-(void)setAge:(NSInteger)age
{
    if (age <= 0 && age >= 300) {
        age = 0;
    }
    _age = age;
}

-(void)setCityID:(NSString *)cityID
{
    if (_cityID != cityID) {
        // fatongzhi
    }
    _cityID = cityID;
}


@end
