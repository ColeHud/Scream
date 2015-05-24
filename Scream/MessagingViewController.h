//
//  MessagingViewController.h
//  Scream
//
//  Created by Cole on 5/23/15.
//  Copyright (c) 2015 Cole Hudson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"

@interface MessagingViewController : UIViewController
@property (strong, nonatomic)PFObject *user;
@end
