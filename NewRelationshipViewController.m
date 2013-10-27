//
//  NewRelationshipViewController.m
//  NextCare
//
//  Created by Omar Metwally on 10/26/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import "NewRelationshipViewController.h"
#import "ServerOAuthController.h"

@interface NewRelationshipViewController ()

@end

@implementation NewRelationshipViewController

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
    caregiverIdTextField.delegate = self;
    patientCodeTextField.delegate = self;
    [[self navigationItem] setTitle:@"Add new relationship"];
    saveButton.layer.cornerRadius = 10.0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[self view] endEditing:YES];
    return YES;
}

- (IBAction)saveButtonClicked:(id)sender {
    
    NSString *caregiverId = caregiverIdTextField.text;
    NSString *patientCode = patientCodeTextField.text;
    
    NSString *relationshipType = description.text;
    
    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    [moreParams setValue:caregiverId forKey:@"caregiver_id"];
    [moreParams setValue:patientCode forKey:@"code"];
    [moreParams setValue:relationshipType forKey:@"relationship_type"];
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:@"relationship" parameters:moreParams HTTPmethod:@"POST" oauthToken:@"" oauthSecret:@""];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path59 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }
                               });
                           }];
    
}

- (IBAction)backgroundPressed:(id)sender {
    [[self view] endEditing:YES];
}
@end
