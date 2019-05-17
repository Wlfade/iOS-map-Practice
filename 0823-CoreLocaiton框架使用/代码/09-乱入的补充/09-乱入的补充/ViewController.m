//
//  ViewController.m
//  09-乱入的补充
//
//  Created by xiaomage on 15/8/23.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
{
    NSInteger _flag;
}
/**   */
@property (nonatomic, copy) NSString *name;



@end

@implementation ViewController

/**
 *  1. 防止对象被提前创建
    2. 防止对象重复创建
    3. 防止对象使用时,还没被创建
    4. 可以在懒加载方法里面,进行初始化操作
 *
 *  @return
 */
- (NSString *)name
{
    if (!_name) {
        _name = @"123";
    }
    return _name;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (_flag == 0) {
        NSLog(@"%@", self.name);
        _flag = 1;
    }
   
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.name = @"张三";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
