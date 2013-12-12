//
//  MockPropertyBuilder.h
//  Daft
//
//  Created by Alan on 12/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "PropertyBuilder.h"

@interface MockPropertyBuilder : PropertyBuilder

@property NSString *JSON;
@property NSArray *arrayToReturn;
@property NSError *errorToSet;

@end
