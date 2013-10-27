//
//  PatientDetailViewController.m
//  NextCare
//
//  Created by Omar Metwally on 10/27/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import "PatientDetailViewController.h"
#import "ServerOAuthController.h"

@interface PatientDetailViewController ()

@end

@implementation PatientDetailViewController
@synthesize currentPatientId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)phoneButtonPressed:(id)sender {
    
    // patientId set in TeamListViewController
    
    NSString *pathFirstHalf = @"user/";
    NSString *pathLastHalf = @"/conference";
    
    NSString *fullPath = [[pathFirstHalf stringByAppendingString:currentPatientId] stringByAppendingString:pathLastHalf];
    NSLog(@"full phone conf path: %@", fullPath);
    
    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:fullPath parameters:moreParams HTTPmethod:@"POST" oauthToken:@"" oauthSecret:@""];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path238 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to initiate conference call" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                       [av show];
                                       
                                       return;
                                   }
                                   
                               });
                           }];

}

@end
