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
            PFInstallation *currentInstallation = [PFInstallation currentInstallation];
            currentInstallation[@"location"] = point;
            
            _user[@"location"] = point;
            [_user saveInBackground];
            
        }
    }];
    
}

//start button
- (IBAction)startButtonPressed:(id)sender
{
    _user[@"chatName"] = _textField.text;
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    if([currentInstallation objectId])
    {
        _user[@"channelUserID"] = [NSString stringWithFormat:@"%@%@", @"a", [currentInstallation objectId]];
    }
    else
    {
        _user[@"channelUserID"] = @"id";
    }
    
    //subscribe to your unique channel
    [currentInstallation addUniqueObject:_user[@"channelUserID"] forKey:@"channels"];
    [currentInstallation saveInBackground];
    
    //get installation info to the user
    [_user saveInBackground];
    
    // Associate the device with a user
    
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
