//
//  PropertyBuilder.m
//  Daft
//
//  Created by Alan on 12/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "PropertyBuilder.h"
#import "Property.h"
#import "ErrorCodes.h"

@implementation PropertyBuilder

-(NSArray *)propertiesFromJSON:(NSString *)JSON
                         error:(NSError **)error{
    
    NSParameterAssert(JSON != nil);
    NSData *unicodeNotation = [JSON dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    
    id JSONObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    
    NSDictionary *parsedObject = (id)JSONObject;
    
    if(parsedObject == nil){
        
        if(error != NULL){
            
            *error = [NSError errorWithDomain:PropertyBuilderErrorDomain code:PropertyBuilderErrorDomainInvalidJSONError userInfo:nil];
            
        }
        
        return nil;
        
    }
    
    NSArray *JSONProperties = [parsedObject valueForKeyPath:@"result.results.ads"];
    
    if(JSONProperties == nil){
        
        if(error != NULL){
            
            *error = [NSError errorWithDomain:PropertyBuilderErrorDomain code:PropertyBuilderErrorDomainMissingDataError userInfo:nil];
            
        }
        
        return nil;
        
    }
    
    NSMutableArray *properties = [NSMutableArray arrayWithCapacity: [JSONProperties count]];
    
    for (NSDictionary *JSONProperty in JSONProperties) {
        
        Property *property = [[Property alloc] init];
        property.fullAddress = [JSONProperty objectForKey: @"full_address"];
        property.imageURL = [JSONProperty objectForKey: @"small_thumbnail_url"];
        [properties addObject:property];
        
    }
    return [properties copy];

}

@end
