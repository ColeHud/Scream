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
    
    _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    #define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    if(IS_OS_8_OR_LATER) {
        [_locationManager requestAlwaysAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
    
    NSLog(@"%f", _locationManager.location.coordinate.latitude);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
