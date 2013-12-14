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

@protocol DaftManagerDelegate <NSObject>

-(void)getPropertiesFailedWithError:(NSError *)error;
-(void)getPropertiesSucceededWithProperties:(NSArray *)properties;

@end


@interface DaftManager : NSObject <DaftCommunicatorDelegate>

@property (weak, nonatomic) id <DaftManagerDelegate> delegate;
@property (strong) DaftCommunicator *communicator;
@property PropertyBuilder *propertyBuilder;

-(void)getProperties;
-(void)fetchPropertiesFailedWithError:(NSError *)error;
-(void)fetchPropertiesSucceededWithJSON:(NSString *)JSON;

@end


