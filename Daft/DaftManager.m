//
//  DaftManager.m
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "DaftManager.h"
#import "DaftCommunicator.h"
#import "PropertyBuilder.h"
#import "ErrorCodes.h"

@implementation DaftManager

#pragma mark - DaftManagerDelegate

-(void)setDelegate:(id<DaftManagerDelegate>)delegate{
    
    if(delegate && ![delegate conformsToProtocol:@protocol(DaftManagerDelegate)]){
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil] raise];
    }
    
    _delegate = delegate;
    
}

-(void)informDelegateOfError:(NSError *)error{
    
    NSDictionary *userInfo = nil;
    
    if(error){
        userInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    
    NSError *managerError = [NSError errorWithDomain:DaftManagerErrorDomain code:DaftManagerErrorCodeSearchFailed userInfo:userInfo];
    
    [self.delegate getFailedWithError:managerError];
    
}

#pragma mark - DaftCommunicator

-(void)getProperties{
    
    [self.communicator fetchProperties];
    
}

-(void)fetchFailedWithError:(NSError *)communicatorError{
    
    [self informDelegateOfError:communicatorError];
    
}

-(void)fetchSucceededWithJSON:(NSString *)JSON{
    
    NSError *propertyBuilderError = nil;
    NSArray *properties = [self.propertyBuilder propertiesFromJSON:JSON error:&propertyBuilderError];
    
    if(!properties){
        
        [self informDelegateOfError:propertyBuilderError];
        
    } else {
        
        [self.delegate getSucceededWithProperties:properties];
    }
    
}

@end
