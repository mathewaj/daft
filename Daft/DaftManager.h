//
//  DaftManager.h
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DaftCommunicator.h"

@class PropertyBuilder;

/**
 * The delegate protocol for the DaftManager class.
 *
 * DaftManager uses this delegate protocol to indicate when information becomes available.
 */
@protocol DaftManagerDelegate <NSObject>

/**
 * The manager was unable to retrieve properties from Daft.
 */
-(void)getPropertiesFailedWithError:(NSError *)error;

/**
 * The manager successfully received properties from Daft.
 */
-(void)getPropertiesSucceededWithProperties:(NSArray *)properties;

@end

/**
 * A façade providing access to the Daft service.
 */
@interface DaftManager : NSObject <DaftCommunicatorDelegate>

@property (weak, nonatomic) id <DaftManagerDelegate> delegate;
@property (strong) DaftCommunicator *communicator;
@property PropertyBuilder *propertyBuilder;


/**
 * Retrieve properties from the Daft API.
 * @note The delegate will receive messages when new information
 *       arrives.
 */
-(void)getProperties;

@end


