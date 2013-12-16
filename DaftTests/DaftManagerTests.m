//
//  PropertyCreation.m
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DaftManager.h"
#import "MockDaftManagerDelegate.h"
#import "MockDaftCommunicator.h"
#import "MockPropertyBuilder.h"
#import "Property.h"

@interface DaftManagerTests : XCTestCase

@end

@implementation DaftManagerTests {
    DaftManager *mgr;
}

- (void)setUp
{
    [super setUp];
    mgr = [[DaftManager alloc] init];
}

- (void)tearDown
{
    mgr = nil;
    [super tearDown];
}

#pragma mark - Delegate Tests

- (void)testNonConformingDelegateCannotBeDaftManagerDelegate
{
    XCTAssertThrows(mgr.delegate = (id <DaftManagerDelegate>)[NSNull null], @"The NSNull object should throw an exception as it does not conform to the delegate protocol");
}

-(void)testConformingObjectCanBeDaftManagerDelegate{
    
    id <DaftManagerDelegate> delegate = [[MockDaftManagerDelegate alloc] init];
    XCTAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol should be used");
    
}

-(void)testDaftManagerDelegateAcceptsNilAsDelegate{
    
    XCTAssertNoThrow(mgr.delegate = nil, @"The object should accept nil as the delegate");
    
}

#pragma mark - Communicator Tests

-(void)testRequestingPropertiesInvolvesRequestingDataFromAPI{
    
    MockDaftCommunicator *communicator = [[MockDaftCommunicator alloc] init];
    mgr.communicator = communicator;
    [mgr getProperties];
    XCTAssertTrue([communicator wasAskedToFetchProperties], @"Requesting properties should require the communicator to fetch data");
    
}

-(void)testDelegateIsNotifiedOfErrorIfCommunicatorError{
    
    NSError *error = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    MockDaftManagerDelegate *delegate = [[MockDaftManagerDelegate alloc] init];
    mgr.delegate = delegate;
    
    [mgr fetchFailedWithError:error];
    XCTAssertNotNil([delegate getError], @"Delegate should have been notified of error");
    
}

-(void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator{
    
    NSError *error = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    MockDaftManagerDelegate *delegate = [[MockDaftManagerDelegate alloc] init];
    mgr.delegate = delegate;
    
    [mgr fetchFailedWithError:error];
    XCTAssertNotEqualObjects([delegate getError], error, @"Delegate should be not be notified at same level of abstraction");
    
}

-(void)testErrorReturnedToDelegateContainsCommunicatorErrorAsUnderlyingError{
    
    NSError *communicatorError = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    
    MockDaftManagerDelegate *delegate = [[MockDaftManagerDelegate alloc] init];
    mgr.delegate = delegate;
    
    [mgr fetchFailedWithError:communicatorError];
    XCTAssertEqualObjects([[[delegate getError] userInfo] objectForKey:NSUnderlyingErrorKey], communicatorError, @"Delegate should receive communicator error as underlying error");
    
}

#pragma mark - Property Creation

-(void)testPropertyJSONIsPassedToPropertyBuilder{
    
    MockPropertyBuilder *propertyBuilder = [[MockPropertyBuilder alloc] init];
    mgr.propertyBuilder = propertyBuilder;
    
    [mgr fetchSucceededWithText:@"JSON"];
    XCTAssertEqualObjects(propertyBuilder.JSON, @"JSON", @"Daft Manager should have provided JSON to Property Builder");
    
}

-(void)testErrorReturnedToDelegateIfPropertyBuilderFails{
    
    MockDaftManagerDelegate *delegate = [[MockDaftManagerDelegate alloc] init];
    mgr.delegate = delegate;
    
    MockPropertyBuilder *propertyBuilder = [[MockPropertyBuilder alloc] init];
    mgr.propertyBuilder = propertyBuilder;
    propertyBuilder.arrayToReturn = nil;
    NSError *error = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    propertyBuilder.errorToSet = error;
    
    [mgr fetchSucceededWithText:@"JSON"];
    XCTAssertNotNil([delegate getError], @"Delegate should have been notified of error");
    
}

-(void)testErrorReturnedToDelegateIsNotErrorNotifiedByPropertyBuilder{
    
    MockDaftManagerDelegate *delegate = [[MockDaftManagerDelegate alloc] init];
    mgr.delegate = delegate;
    
    MockPropertyBuilder *propertyBuilder = [[MockPropertyBuilder alloc] init];
    mgr.propertyBuilder = propertyBuilder;
    propertyBuilder.arrayToReturn = nil;
    NSError *error = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    propertyBuilder.errorToSet = error;
    
    [mgr fetchFailedWithError:error];
    XCTAssertNotEqualObjects([delegate getError], error, @"Delegate should be not be notified at same level of abstraction");
    
}

-(void)testDelegateDoesNotReceiveErrorIfPropertiesReceived{
    
    MockDaftManagerDelegate *delegate = [[MockDaftManagerDelegate alloc] init];
    mgr.delegate = delegate;
    
    MockPropertyBuilder *propertyBuilder = [[MockPropertyBuilder alloc] init];
    mgr.propertyBuilder = propertyBuilder;
    
    Property *property = [[Property alloc] init];
    propertyBuilder.arrayToReturn = [NSArray arrayWithObject:property];
    
    [mgr fetchSucceededWithText:@"JSON"];
    XCTAssertNil([delegate getError], @"Delegate should not have been notified of error");
    
}

-(void)testDelegateReceivesPropertiesIfPropertiesReceived{
    
    MockDaftManagerDelegate *delegate = [[MockDaftManagerDelegate alloc] init];
    mgr.delegate = delegate;
    
    MockPropertyBuilder *propertyBuilder = [[MockPropertyBuilder alloc] init];
    mgr.propertyBuilder = propertyBuilder;
    
    Property *property = [[Property alloc] init];
    propertyBuilder.arrayToReturn = [NSArray arrayWithObject:property];
    
    [mgr fetchSucceededWithText:@"JSON"];
    XCTAssertNotNil([delegate getProperties], @"Delegate should have been provided with properties");
    
}

-(void)testEmptyPropertiesArrayIsAcceptable{
    
    MockDaftManagerDelegate *delegate = [[MockDaftManagerDelegate alloc] init];
    mgr.delegate = delegate;
    
    MockPropertyBuilder *propertyBuilder = [[MockPropertyBuilder alloc] init];
    mgr.propertyBuilder = propertyBuilder;
    
    propertyBuilder.arrayToReturn = [NSArray array];
    
    [mgr fetchSucceededWithText:@"JSON"];
    XCTAssertNotNil([delegate getProperties], @"Delegate should have been provided with properties");
}

@end
