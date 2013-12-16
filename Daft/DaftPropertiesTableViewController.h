//
//  DaftPropertiesTableViewController.h
//  Daft
//
//  Created by Alan on 14/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigurationBlock)(UITableViewCell* cell, id item);

@interface DaftPropertiesTableViewController : UITableViewController

-(void)initialiseDatasource:(NSArray *)items;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) id <UITableViewDataSource> datasource;

@end
