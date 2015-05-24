//
//  MessagingViewController.m
//  Scream
//
//  Created by Cole on 5/23/15.
//  Copyright (c) 2015 Cole Hudson. All rights reserved.
//

#import "MessagingViewController.h"

@interface MessagingViewController ()
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;


@end

@implementation MessagingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
