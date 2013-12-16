//
//  TableViewDataSource.h
//  Daft
//
//  Created by Alan on 14/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DaftPropertiesTableViewController.h"

@interface TableViewDataSource : NSObject <UITableViewDataSource>

-(id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TableViewCellConfigurationBlock)block;

@end
