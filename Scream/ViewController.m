//
//  ViewController.m
//  Scream
//
//  Created by Cole on 5/23/15.
//  Copyright (c) 2015 Cole Hudson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _user = [PFObject objectWithClassName:@"User"];
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            // do something with the new geoPoint
            PFGeoPoint *point = geoPoint;
            
            _user[@"location"] = point;
            
        }
    }];
    
}

//start button
- (IBAction)startButtonPressed:(id)sender
{
    _user[@"chatName"] = _textField.text;
    [_user saveInBackground];
}

//send user variable onward
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showMessaging"])
    {
        MessagingViewController *controller = (MessagingViewController *)segue.destinationViewController;
        controller.user = _user;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
