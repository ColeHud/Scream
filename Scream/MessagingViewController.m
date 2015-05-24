//
//  MessagingViewController.m
//  Scream
//
//  Created by Cole on 5/23/15.
//  Copyright (c) 2015 Cole Hudson. All rights reserved.
//

#import "MessagingViewController.h"
#import "ViewController.h"

@interface MessagingViewController ()
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@end

@implementation MessagingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //id
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    _user[@"channelUserID"] = [NSString stringWithFormat:@"%@%@", @"a", [currentInstallation objectId]];
    [currentInstallation saveInBackground];
    [_user saveInBackground];
    
    //subscribe
    NSString *channel = _user[@"channelUserID"];
    currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:channel forKey:@"channels"];
    [currentInstallation saveInBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//send button
- (IBAction)sendButtonClicked:(id)sender
{
    NSString *string = self.inputTextField.text;
    [self.inputTextField setText:@""];
    
    //get the user's geopoint
    PFGeoPoint *point = _user[@"location"];
    // Create a query for places
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    // Interested in locations near user.
    [query whereKey:@"location" nearGeoPoint:point withinMiles:1];
    // Limit what could be a lot of points.
    query.limit = 10000;
    // Final list of objects
    NSArray *objects = [query findObjects];
    
    NSMutableArray *channels;
    
    for(PFObject *p in objects)
    {
        NSString *channel = p[@"channelUserID"];
        
        NSLog(channel);
        
        //only push to people who aren't you
        NSLog(@"%@, %@", channel, _user[@"channelUserID"]);
        if(![channel isEqualToString:_user[@"channelUserID"]])
        {
            PFPush *push = [[PFPush alloc] init];
            
            // Be sure to use the plural 'setChannels'.
            [push setChannel:channel];
            [push setMessage:string];
            [push sendPushInBackground];
        }
        
    }
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
