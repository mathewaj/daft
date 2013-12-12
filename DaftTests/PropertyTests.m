//
//  PropertyTests2.m
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Property.h"

@interface PropertyTests : XCTestCase

@end

@implementation PropertyTests {
    
    Property *newProperty;
    
}

- (void)setUp
{
    [super setUp];
    newProperty = [[Property alloc] init];
}

- (void)tearDown
{
    newProperty = nil;
    [super tearDown];
    
}

- (void)testThatPropertyExists
{
    XCTAssertNotNil(newProperty, @"Should be able to create a property object");
}

-(void)testThatPropertyHasAFullAddress{
    
    newProperty.fullAddress = @"123 Fake Street";
    XCTAssertEqualObjects(newProperty.fullAddress, @"123 Fake Street", @"Property should have the full address given to it");
}

-(void)testThatPropertyHasAnImageURL{
    
    newProperty.imageURL = @"http://daft.ie/property.png";
    XCTAssertEqualObjects(newProperty.imageURL, @"http://daft.ie/property.png", @"Property should have the image URL given to it");
}

@end
