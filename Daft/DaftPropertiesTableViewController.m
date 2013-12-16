//
//  DaftPropertiesTableViewController.m
//  Daft
//
//  Created by Alan on 14/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "DaftPropertiesTableViewController.h"
#import "TableViewDataSource.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Property.h"

@implementation DaftPropertiesTableViewController

-(void)initialiseDatasource:(NSArray *)items{
    
    self.datasource =  [[TableViewDataSource alloc] initWithItems:items cellIdentifier:@"Cell" configureCellBlock:^(UITableViewCell *cell, Property *property) {
        
        cell.textLabel.text = property.fullAddress;
        [cell.imageView setImageWithURL:[NSURL URLWithString:property.imageURL]
                       placeholderImage:[UIImage imageNamed:@"Placeholder"]];
        
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self.datasource;
    
}

@end
