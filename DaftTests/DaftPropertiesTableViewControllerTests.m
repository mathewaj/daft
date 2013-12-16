//
//  DaftPropertiesTableViewControllerTests.m
//  Daft
//
//  Created by Alan on 14/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DaftPropertiesTableViewController.h"
#import "TableViewDataSource.h"
#import "Property.h"

@interface DaftPropertiesTableViewControllerTests : XCTestCase

@end

@implementation DaftPropertiesTableViewControllerTests {
    
    DaftPropertiesTableViewController *vc;
}

- (void)setUp
{
    [super setUp];
    vc = [[DaftPropertiesTableViewController alloc] init];
}

- (void)tearDown
{
    vc = nil;
    [super tearDown];
}

- (void)testVCHasATableView{
    
    vc.tableView = [[UITableView alloc] init];
    XCTAssertNotNil(vc.tableView, @"VC should have a table view");
}

-(void)testVCHasADatasource{
    
    TableViewCellConfigurationBlock block = ^(UITableViewCell *a, id b){};
    vc.datasource = [[TableViewDataSource alloc] initWithItems:@[] cellIdentifier:@"foo" configureCellBlock:block];
    XCTAssertNotNil(vc.datasource, @"VC should have a datasource");
}

-(void)testVCConnectsDataSourceToTableViewOnLoading{
    
    UITableView *tableView = [[UITableView alloc] init];
    vc.tableView = tableView;
    TableViewCellConfigurationBlock block = ^(UITableViewCell *a, id b){};
    vc.datasource = [[TableViewDataSource alloc] initWithItems:@[] cellIdentifier:@"foo" configureCellBlock:block];
    [vc viewDidLoad];
    XCTAssertEqual(vc.tableView.dataSource, vc.datasource, @"VC should have connected the table view to its datasource");
    
}
@end
