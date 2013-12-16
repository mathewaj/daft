//
//  TableViewDataSource.m
//  Daft
//
//  Created by Alan on 14/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "TableViewDataSource.h"

@interface TableViewDataSource ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (readwrite, copy) TableViewCellConfigurationBlock block;

@end

@implementation TableViewDataSource

-(id)init{
    
    return nil;
}

-(id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TableViewCellConfigurationBlock)block{
    
    if((self = [super init])){
        
        self.items = items;
        self.cellIdentifier = cellIdentifier;
        self.block = block;
    }
    return self;
    
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    return self.items[(NSUInteger)indexPath.row];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSParameterAssert(section == 0);
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.block(cell,item);
    
    return cell;
}

@end
