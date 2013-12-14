//
//  DaftCommunicator.h
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DaftCommunicatorDelegate <NSObject>

-(void)fetchFailedWithError:(NSError *)error;
-(void)fetchSucceededWithText:(NSString *)text;

@end

@interface DaftCommunicator : NSObject <NSURLConnectionDataDelegate>

@property (weak) id <DaftCommunicatorDelegate> delegate;

@property (strong) NSURL *fetchURL;
@property (strong) NSURLConnection *connection;
@property (strong) NSMutableData *receivedData;

-(void)fetchProperties;
-(void)cancelAndDiscardConnection;

@end
