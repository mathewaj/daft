//
//  MockPropertyBuilder.m
//  Daft
//
//  Created by Alan on 12/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "MockPropertyBuilder.h"

@implementation MockPropertyBuilder

-(NSArray *)propertiesFromJSON:(NSString *)JSON
                         error:(NSError **)error{
    self.JSON = JSON;
    *error = self.errorToSet;
    return self.arrayToReturn;
}

@end
