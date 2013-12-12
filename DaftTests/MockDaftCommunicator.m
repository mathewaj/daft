//
//  MockDaftCommunicator.m
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "MockDaftCommunicator.h"

@implementation MockDaftCommunicator {
    
    BOOL wasAskedToFetchProperties;
    
}

-(void)fetchProperties{
    
    wasAskedToFetchProperties = YES;
    
}

-(BOOL)wasAskedToFetchProperties{
    
    return wasAskedToFetchProperties;
    
}

@end
