//
//  ViewController.h
//  Daft
//
//  Created by Alan on 11/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaftManager.h"

@interface ButtonViewController : UIViewController <DaftManagerDelegate>

@property (nonatomic, strong) NSArray *properties;
@property (nonatomic, strong) DaftManager *manager;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)getPropertiesButtonPressed:(id)sender;

@end
