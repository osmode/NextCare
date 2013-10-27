//
//  NewTodoItemViewController.m
//  NextCare
//
//  Created by Omar Metwally on 10/26/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import "NewTodoItemViewController.h"
#import "ServerOAuthController.h"

@interface NewTodoItemViewController ()

@end

@implementation NewTodoItemViewController

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
    [[self navigationItem] setTitle:@"New Todo Item"];
    caregiverIdField.delegate = self;
    patientIdField.delegate = self;
    descriptionTextView.delegate = self;
    
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

- (IBAction)saveButtonPressed:(id)sender {
    
    NSString *caregiverId = caregiverIdField.text;
    NSString *patientId = patientIdField.text;
    
    NSString *description = descriptionTextView.text;
    
    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    [moreParams setValue:caregiverId forKey:@"caregiver_id"];
    [moreParams setValue:patientId forKey:@"patient_id"];
    [moreParams setValue:description forKey:@"description"];
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:@"todo" parameters:moreParams HTTPmethod:@"POST" oauthToken:@"" oauthSecret:@""];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path77 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }
                                   /*
                                   NSArray *a = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   
                                   NSDictionary *d = [a objectAtIndex:1];
                                   
                                   NSNumber *idNumber = [d valueForKey:@"id"];
                                   
                                   NSString *idInteger = [idNumber stringValue];
                                   
                                   
                                   NSString *tokenString = [d valueForKey:@"token"];
                                   NSString *email = [d valueForKey:@"email"];
                                   NSString *phone = [d valueForKey:@"phone"];
                                   NSString *type = [d valueForKey:@"type"];
                                   NSString *code = [d valueForKey:@"code"];
                                   
                                   // store id and token
                                   [[NCTeamDataStore sharedStore] setUserId:[idInteger intValue]];
                                   [[NCTeamDataStore sharedStore] setUserToken:tokenString];
                                   [[NCTeamDataStore sharedStore] setEmail:email];
                                   [[NCTeamDataStore sharedStore] setPhone:phone];
                                   [[NCTeamDataStore sharedStore] setCode:code];
                                   
                                   // populate any existing to do lists
                                   [[NCTeamDataStore sharedStore] populateToDoList:idInteger];
                                   
                                   // populate team lists and to do lists depending on whether or not a patient/caregiver login, or if a physician logs in
                                   if ([type isEqualToString:@"patient"] || [type isEqualToString:@"caregiver"]) {
                                       [[NCTeamDataStore sharedStore] populatePatientCaregiverTeam:idInteger];
                                   } else {
                                       [[NCTeamDataStore sharedStore] populatePhysiciansPatients:idInteger];
                                   }
                                   */
                                   
                               });
                           }];

}

- (IBAction)backgroundTouched:(id)sender {
    [[self view] endEditing:YES];
}
@end
