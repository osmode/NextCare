//
//  LoginViewController.h
//  NextCare
//
//  Created by Omar Metwally on 10/24/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WithingsOAuth1Controller, ServerOAuthController;
@interface LoginViewController : UIViewController <UINavigationControllerDelegate, UITextFieldDelegate>
{
    
    __weak IBOutlet UIButton *withingsButton;
    __weak IBOutlet UITextField *emailTextField;
    __weak IBOutlet UITextField *passwordTextField;
    __weak IBOutlet UIButton *loginButton;
    __weak IBOutlet UIButton *authenticateButton;
    
}

@property (nonatomic, strong) WithingsOAuth1Controller *withingsOAuth1Controller;
@property (nonatomic, strong) ServerOAuthController *serverOAuthController;
@property (nonatomic, copy) void (^selectedActionBlock)(void);
@property (nonatomic, strong) NSString *oauthToken;
@property (nonatomic, strong) NSString *oauthTokenSecret;

- (IBAction)withingsButtonPressed:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;
- (WithingsOAuth1Controller *)withingsOAuth1Controller;
-(ServerOAuthController *)serverOAuth1Controller;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)authenticateButtonPressed:(id)sender;


@end
