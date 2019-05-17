//
//  ViewController.m
//  09-乱入的补充
//
//  Created by 王顺子 on 15/8/18.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Person *p = [[Person alloc] init];
    p.name = @"熊大";

    // 使用block进行遍历数组,里面对应的参数不再是id类型,而是你之前针对于此数组指定的类型
    [p.friends enumerateObjectsUsingBlock:^(Person * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

    }];

}



@end
