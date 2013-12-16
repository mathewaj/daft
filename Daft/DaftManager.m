//
//  DaftManager.m
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "DaftManager.h"
#import "PropertyBuilder.h"
#import "ErrorCodes.h"

@implementation DaftManager

#pragma mark - DaftManager

-(id)init{
    
    if((self = [super init])){
        
        self.communicator = [[DaftCommunicator alloc] init];
        self.communicator.delegate = self;
        self.propertyBuilder = [[PropertyBuilder alloc] init];
    }
    
    return self;
    
}

-(void)getProperties{
    
    [self.communicator fetchProperties];
    
}

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
    
    NSError *managerError = [NSError errorWithDomain:DaftManagerErrorDomain code:DaftManagerErrorSearchFailed userInfo:userInfo];
    
    [self.delegate getPropertiesFailedWithError:managerError];
    
}

#pragma mark - DaftCommunicatorDelegate Methods

-(void)fetchFailedWithError:(NSError *)communicatorError{
    
    [self informDelegateOfError:communicatorError];
}

-(void)fetchSucceededWithText:(NSString *)JSON{
    
    NSError *propertyBuilderError = nil;
    NSArray *properties = [self.propertyBuilder propertiesFromJSON:JSON error:&propertyBuilderError];
    
    if(!properties){
        
        [self informDelegateOfError:propertyBuilderError];
        
    } else {
        
        [self.delegate getPropertiesSucceededWithProperties:properties];
    }
    
}


@end
