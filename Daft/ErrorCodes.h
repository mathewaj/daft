//
//  ErrorCodes.h
//  Daft
//
//  Created by Alan on 12/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorCodes : NSObject

extern NSString *const DaftManagerErrorDomain;
extern NSString *const DaftCommunicatorErrorDomain;
extern NSString *const PropertyBuilderErrorDomain;

typedef NS_ENUM(NSInteger, DaftManagerErrorCode) {
    DaftManagerErrorSearchFailed
};


typedef NS_ENUM(NSInteger, PropertyBuilderErrorDomainCode) {
    PropertyBuilderErrorDomainInvalidJSONError,
    PropertyBuilderErrorDomainMissingDataError
};

@end
