//
//  Person.h
//  09-乱入的补充
//
//  Created by 王顺子 on 15/8/18.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
/**
    nonnull : 标示当前属性不为空,让外界放心用,只做标示用,即使为空,也木有办法
    相当于swift里面的 ! 号
 */
@property (nonnull, nonatomic, strong) NSString *name;

/**
    nullable : 标示当前属性可能为空,让外界使用时注意
    相当于swift里面的 ? 号
 */
@property (nullable, nonatomic, strong) NSString *petName;

/**
    有点类似于泛型和id的结合,目的是告诉开发人员,数组内装的什么鬼
    代表数组内的对象 is kind of 所填的类型 , 当开发人员用的时候不需要再进行从父类强转到子类
 */
@property (nullable , nonatomic, strong) NSArray<Person *> *friends;

@end
