//
//  ViewController.m
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import "ButtonViewController.h"
#import "DaftPropertiesTableViewController.h"
#import "ErrorCodes.h"


@implementation ButtonViewController

#pragma mark - Button View Controller

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self = [super initWithCoder:aDecoder])){
        
        self.manager = [[DaftManager alloc] init];
        self.manager.delegate = self;
        
    }
    
    return self;
    
}

- (IBAction)getPropertiesButtonPressed:(id)sender {
    
    [self.manager getProperties];
    self.spinner.hidden = NO;
    [self.spinner startAnimating];
    self.button.enabled = NO;
    
}

#pragma mark - DaftManagerDelegate

-(void)getPropertiesFailedWithError:(NSError *)error{
    
    [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Property Search Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    self.button.enabled = YES;
    [self.spinner stopAnimating];
    
}


-(void)getPropertiesSucceededWithProperties:(NSArray *)properties{
    
    self.properties = properties;
    [self performSegueWithIdentifier:@"PropertyList" sender:self];
    
    self.button.enabled = YES;
    [self.spinner stopAnimating];
}

#pragma mark - PrepareForSegue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DaftPropertiesTableViewController *vc = (DaftPropertiesTableViewController *)segue.destinationViewController;
    [vc initialiseDatasource:self.properties];
    
    
}

@end
