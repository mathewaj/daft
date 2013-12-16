//
//  MockDaftManager.m
//  Daft
//
//  Created by Alan on 13/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "MockDaftManager.h"

@implementation MockDaftManager {
    
    BOOL propertiesRequested;
    
}

-(void)fetchFailedWithError:(NSError *)error{
    
    self.error = error;
}

-(void)fetchSucceededWithText:(NSString *)text{
    
    self.text = text;
}

-(void)getProperties{
    
    propertiesRequested = YES;
    
}

-(BOOL)propertiesRequested{
    
    return propertiesRequested;
}

@end
