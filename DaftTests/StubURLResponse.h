//
//  StubURLResponse.h
//  Daft
//
//  Created by Alan on 13/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StubURLResponse : NSObject{
    
   NSInteger statusCode;
}

-(id)initWithStatusCode:(NSInteger)code;
-(NSInteger)statusCode;

@end
