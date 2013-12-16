//
//  DaftCommunicatorTests.m
//  Daft
//
//  Created by Alan on 13/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DaftCommunicator.h"
#import "StubURLResponse.h"
#import "MockDaftManager.h"

static NSString *httpRequestTest = @"https://api.daft.com/v2/json/search_sale?parameters={\"api_key\":\"49f46a8c8503f8b8eaa02a6ad981fd546ab13de4\",\"query\":{\"perpage\":50}}";

@interface DaftCommunicatorTests : XCTestCase

@end

@implementation DaftCommunicatorTests {
    DaftCommunicator *communicator;
}

- (void)setUp
{
    [super setUp];
    communicator = [[DaftCommunicator alloc] init];
}

- (void)tearDown
{
    communicator = nil;
    [super tearDown];
}

- (void)testThatFetchCallSetsCorrectURL
{
    NSString *stringURL = [httpRequestTest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *testURL = [NSURL URLWithString:stringURL];
    [communicator fetchProperties];
    XCTAssertTrue([[communicator.fetchURL absoluteString] isEqualToString:[testURL absoluteString]], @"Correct API should be set");
    
}

-(void)testThatFetchCallCreatesURLConnection{
    
    [communicator fetchProperties];
    XCTAssertNotNil([communicator connection], @"Connection should be opened");
    [communicator cancelAndDiscardConnection];
}

-(void)testThatNewFetchCancelsExistingConnection{
    
    [communicator fetchProperties];
    NSURLConnection *firstConnection = [communicator connection];
    [communicator fetchProperties];
    XCTAssertFalse([[communicator connection] isEqual:firstConnection], @"Communicator should have created new connection");
    [communicator cancelAndDiscardConnection];
}

-(void)testReceivingResponseDiscardsExistingData{
    
    communicator.receivedData = (NSMutableData *)[@"Existing Data" dataUsingEncoding:NSUTF8StringEncoding];
    [communicator fetchProperties];
    [communicator connection:nil didReceiveResponse:nil];
    XCTAssertEqual([communicator.receivedData length], (NSUInteger)0, @"Data should have been discarded");
    
}

-(void)testReceivingResponseWith404ErrorReturnsErrorToDelegate{
    
    MockDaftManager *manager = [[MockDaftManager alloc] init];
    communicator.delegate = manager;
    
    StubURLResponse *notFoundErrorMessage = [[StubURLResponse alloc] initWithStatusCode:404];
    [communicator connection:nil didReceiveResponse:(NSURLResponse *)notFoundErrorMessage];
    
    XCTAssertEqual(manager.error.code, 404, @"Correct error returned to delegate");
    
}

-(void)testNoErrorReturnedOn200Status{
    
    MockDaftManager *manager = [[MockDaftManager alloc] init];
    communicator.delegate = manager;
    
    StubURLResponse *notFoundErrorMessage = [[StubURLResponse alloc] initWithStatusCode:200];
    [communicator connection:nil didReceiveResponse:(NSURLResponse *)notFoundErrorMessage];
    
    XCTAssertNil(manager.error, @"Should be no error on 200 response");
    
}

-(void)testConnectionFailingPassesErrorToDelegate{
    
    MockDaftManager *manager = [[MockDaftManager alloc] init];
    communicator.delegate = manager;
    NSError *error = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    
    [communicator connection:nil didFailWithError:error];
    
    XCTAssertNotNil(manager.error, @"Failure to connect should cause error");
}

-(void)testSuccessfulSearchPassesDataToDelegate{
    
    MockDaftManager *manager = [[MockDaftManager alloc] init];
    communicator.delegate = manager;
    communicator.receivedData = (NSMutableData *)[@"Data Success" dataUsingEncoding:NSUTF8StringEncoding];
    [communicator connectionDidFinishLoading:nil];
    XCTAssertNotNil(manager.text, @"Failure to connect should cause error");
    
}

-(void)testAdditionalDataAppendedToDownload{
    
    MockDaftManager *manager = [[MockDaftManager alloc] init];
    communicator.delegate = manager;
    communicator.receivedData = (NSMutableData *)[@"Data Success" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *extraData = [@" Extra" dataUsingEncoding:NSUTF8StringEncoding];
    
    [communicator connection:nil didReceiveData:extraData];
    
    NSString *resultString = [[NSString alloc] initWithData:communicator.receivedData encoding:NSUTF8StringEncoding];
    
    XCTAssertTrue([resultString isEqualToString:@"Data Success Extra"], @"Data should have been appended to initial data");
    
}




@end
