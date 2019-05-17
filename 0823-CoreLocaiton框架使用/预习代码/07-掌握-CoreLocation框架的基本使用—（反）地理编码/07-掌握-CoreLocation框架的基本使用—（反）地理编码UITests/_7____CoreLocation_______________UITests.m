//
//  _7____CoreLocation_______________UITests.m
//  07-掌握-CoreLocation框架的基本使用—（反）地理编码UITests
//
//  Created by 王顺子 on 15/8/5.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface _7____CoreLocation_______________UITests : XCTestCase

@end

@implementation _7____CoreLocation_______________UITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
