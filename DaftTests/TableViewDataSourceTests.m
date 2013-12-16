//
//  TableViewDataSourceTests.m
//  Daft
//
//  Created by Alan on 14/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TableViewDataSource.h"
#import "DaftPropertiesTableViewController.h"
#import "Property.h"

@interface TableViewDataSourceTests : XCTestCase

@end

@implementation TableViewDataSourceTests {
    
    TableViewDataSource *datasource;
}

- (void)setUp
{
    [super setUp];
    TableViewCellConfigurationBlock block = ^(UITableViewCell *a, id b){};
    datasource = [[TableViewDataSource alloc] initWithItems:@[]
                                      cellIdentifier:@"foo"
                                  configureCellBlock:block];
}

- (void)tearDown
{
    datasource = nil;
    [super tearDown];
}

-(void)testInitializingWithoutItems{
    
    XCTAssertNil([[TableViewDataSource alloc] init], @"Initializing without items should not be allowed.");
    
}

- (void)testInitializingWithItems{

    XCTAssertNotNil(datasource, @"Initializing with items should be allowed.");
}

-(void)testDatasourceReturnsOneTableRowWhenOneItem{
    
    Property *property = [[Property alloc] init];
    NSArray *propertyArray = [NSArray arrayWithObject:property];
    TableViewCellConfigurationBlock block = ^(UITableViewCell *a, id b){};
    datasource = [[TableViewDataSource alloc] initWithItems:propertyArray
                                             cellIdentifier:@"foo"
                                         configureCellBlock:block];
    
    XCTAssertEqual([datasource tableView:nil numberOfRowsInSection:0], (NSInteger)[propertyArray count], @"Number of rows should match number of items in object array");
}

-(void)testDatasourceReturnsTwoTableRowsWhenTwoItems{
    
    Property *property1 = [[Property alloc] init];
    Property *property2 = [[Property alloc] init];
    NSArray *propertyArray = [NSArray arrayWithObjects:property1, property2, nil];
    TableViewCellConfigurationBlock block = ^(UITableViewCell *a, id b){};
    datasource = [[TableViewDataSource alloc] initWithItems:propertyArray
                                             cellIdentifier:@"foo"
                                         configureCellBlock:block];
    XCTAssertEqual([datasource tableView:nil numberOfRowsInSection:0], (NSInteger)[propertyArray count], @"Number of rows should match number of items in object array");
}

-(void)testOnlyOneSectionInTableView{
    
    XCTAssertThrows([datasource tableView:nil numberOfRowsInSection:1], @"Table view is only expected to have one section");
}

@end
