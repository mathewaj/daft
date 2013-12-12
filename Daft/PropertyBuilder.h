//
//  PropertyBuilder.h
//  Daft
//
//  Created by Alan on 12/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyBuilder : NSObject

-(NSArray *)propertiesFromJSON:(NSString *)JSON
                         error:(NSError **)error;

@end
