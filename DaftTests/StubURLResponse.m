//
//  StubURLResponse.m
//  Daft
//
//  Created by Alan on 13/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "StubURLResponse.h"

@implementation StubURLResponse

-(id)initWithStatusCode:(NSInteger)code{
    
    if((self = [super init])){
        
        statusCode = code;
        
    }
    return self;
}

-(NSInteger)statusCode{
    return statusCode;
}


@end
