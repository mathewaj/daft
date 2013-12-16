//
//  DaftCommunicator.m
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "DaftCommunicator.h"
#import "ErrorCodes.h"

static NSString *httpRequest = @"https://api.daft.com/v2/json/search_sale?parameters={\"api_key\":\"49f46a8c8503f8b8eaa02a6ad981fd546ab13de4\",\"query\":{\"perpage\":50}}";

@interface DaftCommunicator ()

@end

@implementation DaftCommunicator

-(void)launchConnectionForRequest:(NSURLRequest *)request{
    
    [self cancelAndDiscardConnection];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void)fetchProperties{
    
    NSString *stringURL = [httpRequest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.fetchURL = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.fetchURL];
    [self launchConnectionForRequest:request];
    
}

-(void)cancelAndDiscardConnection{
    
    [self.connection cancel];
    self.connection = nil;
    
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    self.receivedData = nil;
    self.fetchURL = nil;
    self.connection = nil;
    [self.delegate fetchFailedWithError:error];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    self.receivedData = nil;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if([httpResponse statusCode] != 200){
        
        NSError *error = [NSError errorWithDomain:DaftCommunicatorErrorDomain code:[httpResponse statusCode] userInfo:nil];
        [self.delegate fetchFailedWithError:error];
        
    } else {
        
        self.receivedData = [[NSMutableData alloc] init];
    }
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    self.fetchURL = nil;
    self.connection = nil;
    NSString *receivedText = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    [self.delegate fetchSucceededWithText:receivedText];
    
}

@end
