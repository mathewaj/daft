//
//  ButtonViewControllerTests.m
//  Daft
//
//  Created by Alan on 16/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ButtonViewController.h"
#import "DaftPropertiesTableViewController.h"
#import "MockDaftManager.h"

@interface ButtonViewControllerTests : XCTestCase

@end

@implementation ButtonViewControllerTests {
    
    UIStoryboard *storyboard;
    ButtonViewController *vc;
    
}

- (void)setUp
{
    [super setUp];
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    vc = [storyboard instantiateViewControllerWithIdentifier:@"ButtonViewController"];
    [vc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    
}

- (void)tearDown
{
    vc = nil;
    [super tearDown];
}

- (void)testViewControllerCanStoreProperties
{
    XCTAssertNoThrow([vc setProperties:[NSArray array]], @"View Controller should be able to store properties array");
    
}

- (void)testViewControllerHasADaftManager
{
    MockDaftManager *manager = [[MockDaftManager alloc] init];
    XCTAssertNoThrow([vc setManager:(DaftManager *)manager], @"View Controller should have a DaftManager");
    
}

-(void)testPressingButtonMeansProgressIndicatorStarts{
 
    [vc getPropertiesButtonPressed:nil];
    XCTAssertFalse(vc.spinner.hidden, @"Progress Indicator should be visible");
    XCTAssertTrue([vc.spinner isAnimating], @"Progress Indicator should be animating");
    
}

-(void)testButtonIsDisabledDuringDaftManagerSearch{
    
    [vc getPropertiesButtonPressed:nil];
    XCTAssertFalse(vc.button.enabled, @"Button should be disabled during the API search");
    
    
}

-(void)testProgressIndicatorIsHiddenInitially{

    XCTAssertTrue(vc.spinner.hidden, @"Progress Indicator should not be visible initially");
    
}

-(void)testProgressIndicatorHidesOnDaftManagerFailReturn{
    
    [vc getPropertiesButtonPressed:nil];
    [vc getPropertiesFailedWithError:nil];
    XCTAssertTrue(vc.spinner.hidden, @"Progress Indicator should be visible");
    XCTAssertFalse(vc.spinner.isAnimating, @"Progress Indicator should not be animating");
    
}

-(void)testProgressIndicatorHidesOnDaftManagerSuccessReturn{
    
    UINavigationController *navController;
    navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [vc getPropertiesButtonPressed:nil];
    [vc getPropertiesSucceededWithProperties:[NSArray array]];
    XCTAssertTrue(vc.spinner.hidden, @"Progress Indicator should not be visible");
    XCTAssertFalse(vc.spinner.isAnimating, @"Progress Indicator should not be animating");
    
}

-(void)testPressingButtonsSendsRequestToDaftManager{
    
    MockDaftManager *manager = [[MockDaftManager alloc] init];
    vc.manager = (DaftManager *)manager;
    [vc getPropertiesButtonPressed:nil];
    
    XCTAssertTrue([manager propertiesRequested], @"Button press should send request to DaftManager");
    
}

-(void)testSuccessfulResponseMeansPresentingNewVC{
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [vc getPropertiesSucceededWithProperties:[NSArray array]];
    UIViewController *currentTopVC = navController.topViewController;
    
    XCTAssertFalse([currentTopVC isEqual:vc], @"Button View Controller should no longer be top view controller");

}

@end
