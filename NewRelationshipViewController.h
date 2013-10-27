//
//  NewRelationshipViewController.h
//  NextCare
//
//  Created by Omar Metwally on 10/26/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewRelationshipViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
{
    
    __weak IBOutlet UILabel *caregiverLabel;
    __weak IBOutlet UILabel *patientCodeLabel;
    __weak IBOutlet UILabel *descriptionLabel;
    
    __weak IBOutlet UITextField *caregiverIdTextField;
    __weak IBOutlet UITextField *patientCodeTextField;
    
    __weak IBOutlet UITextField *description;
    __weak IBOutlet UIButton *saveButton;
}

- (IBAction)saveButtonClicked:(id)sender;
- (IBAction)backgroundPressed:(id)sender;


@end
