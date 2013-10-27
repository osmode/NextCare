//
//  LoginViewController.m
//  NextCare
//
//  Created by Omar Metwally on 10/24/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import "LoginViewController.h"
#import "OAuthLoginViewController.h"
#import "WithingsOAuth1Controller.h"
#import "WithingsApiDataStore.h"
#import "ServerOAuthController.h"
#import "NCTeamDataStore.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize withingsOAuth1Controller, serverOAuthController, oauthToken, oauthTokenSecret, selectedActionBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    emailTextField.delegate = self;
    passwordTextField.delegate = self;
    
    [[self navigationItem] setTitle:@"Login"];
    loginButton.layer.cornerRadius = 10.0;
    authenticateButton.layer.cornerRadius = 10.0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (IBAction)authenticateButtonPressed:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://162.243.36.210/test"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   //NSLog(@"path35 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   
                                   NSString *idString = [d valueForKey:@"id"];
                                   NSString *tokenString = [d valueForKey:@"token"];
                                   
                                   [[NCTeamDataStore sharedStore] setUserId:idString];
                                   [[NCTeamDataStore sharedStore] setUserToken:tokenString];
                                   

                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }
                                   
    
                                   
                                   // store user id and token after login
                                   //[[NCTeamDataStore sharedStore] setUserId:[d valueForKey:@"id"]];
                                   
                                   
                               });
                           }];
    
    NSLog(@"yyyyyyy");
    NSLog(@"id: %@, token: %@", [[NCTeamDataStore sharedStore] userId], [[NCTeamDataStore sharedStore] userToken]);
}

- (IBAction)withingsButtonPressed:(id)sender {
    
    OAuthLoginViewController *flvc = [[OAuthLoginViewController alloc] init];
    self.navigationController.delegate = self;
    [[flvc navigationItem] setTitle:@"Sync Withings data"];
    
    [flvc setCompletionBlock:^{
        
        [self.withingsOAuth1Controller loginWithWebView:flvc.webView completion:^(NSDictionary *oauthTokens, NSError *error) {
            
            if (!error) {
                // Store your tokens for authenticating your later requests, consider storing the tokens in the Keychain
                self.oauthToken = oauthTokens[@"oauth_token"];
                self.oauthTokenSecret = oauthTokens[@"oauth_token_secret"];
                
                NSLog(@"oauthToken: %@, oauthTokenSecret: %@", self.oauthToken, self.oauthTokenSecret);
                
                UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                aiv.color = [UIColor grayColor];
                aiv.center = [[flvc webView] center];
                [flvc.webView addSubview:aiv];
                [aiv startAnimating];
                
                [[WithingsApiDataStore sharedStore] getBloodPressureData:self.oauthToken oauthSecretIn:self.oauthTokenSecret userID:[self.withingsOAuth1Controller userid_class] withCompletion:^{
                    
                    [aiv stopAnimating];
                    
                }];
            }
            else
            {
                NSLog(@"Error authenticating: %@", error.localizedDescription);
            }
            [self dismissViewControllerAnimated:YES completion: ^{
                self.withingsOAuth1Controller = nil;
            }];
        }];
    }];
    
    // push FitbitLoginViewController only if there are no errors
    [[self navigationController] pushViewController:flvc animated:YES];
    
}

- (IBAction)loginButtonPressed:(id)sender {

    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    [moreParams setValue:emailTextField.text forKey:@"email"];
    
    [moreParams setValue:passwordTextField.text forKey:@"password"];
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:@"user/login" parameters:moreParams HTTPmethod:@"POST" oauthToken:@"" oauthSecret:@""];
        
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path35 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }
                                   
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
                                   if ([type isEqualToString:@"patient"] ) {
                                       [[NCTeamDataStore sharedStore] populatePatientCaregiverTeam:idInteger];
                                   } else {
                                       [[NCTeamDataStore sharedStore] populatePhysiciansPatients:idInteger];
                                   }
            
                                   
                               });
                           }];

}

- (WithingsOAuth1Controller *)withingsOAuth1Controller
{
    if (withingsOAuth1Controller == nil) {
        withingsOAuth1Controller = [[WithingsOAuth1Controller alloc] init];
    }
    return withingsOAuth1Controller;
}

-(ServerOAuthController *)serverOAuth1Controller
{
    if (serverOAuthController == nil) {
        serverOAuthController = [[ServerOAuthController alloc] init];
    }
    return serverOAuthController;
}


@end
