//
//  DaftManager.h
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DaftCommunicator;
@class PropertyBuilder;

@protocol DaftManagerDelegate <NSObject>

-(void)getFailedWithError:(NSError *)error;
-(void)getSucceededWithProperties:(NSArray *)properties;

@end


@interface DaftManager : NSObject

@property (weak, nonatomic) id <DaftManagerDelegate> delegate;

@property (strong) DaftCommunicator *communicator;
@property PropertyBuilder *propertyBuilder;

-(void)getProperties;
-(void)fetchFailedWithError:(NSError *)error;
-(void)fetchSucceededWithJSON:(NSString *)JSON;


@end


