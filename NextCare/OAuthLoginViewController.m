//
//  FitbitLoginViewController.m
//  PulseBeat
//
//  Created by Omar Metwally on 10/9/13.
//  Copyright (c) 2013 Logisome. All rights reserved.
//

#import "OAuthLoginViewController.h"

@interface OAuthLoginViewController ()

@end

@implementation OAuthLoginViewController
@synthesize completionBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //[[self navigationItem] setTitle:@"Sync Fitbit Data"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    completionBlock();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end