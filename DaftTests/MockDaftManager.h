//
//  MockDaftManager.h
//  Daft
//
//  Created by Alan on 13/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "DaftManager.h"
#import "DaftCommunicator.h"

@interface MockDaftManager : NSObject <DaftCommunicatorDelegate>

@property NSError *error;
@property NSString *text;

@end
