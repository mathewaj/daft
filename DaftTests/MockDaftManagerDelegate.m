//
//  MockDaftManagerDelegate.m
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "MockDaftManagerDelegate.h"

@implementation MockDaftManagerDelegate {
    
    NSArray *storedProperties;
    NSError *storedError;
    
}

-(void)getPropertiesFailedWithError:(NSError *)error{
    
    storedError = error;
    
}

-(void)getPropertiesSucceededWithProperties:(NSArray *)properties{
    
    storedProperties = properties;
}

-(NSError *)getError{
    
    return storedError;
}

-(NSArray *)getProperties{
    
    return storedProperties;
}

@end
