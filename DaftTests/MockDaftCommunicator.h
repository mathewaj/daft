//
//  MockDaftCommunicator.h
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DaftCommunicator.h"

@interface MockDaftCommunicator : DaftCommunicator

-(BOOL)wasAskedToFetchProperties;
-(NSURL *)fetchURL;

@end
