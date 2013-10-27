//
//  NewTodoItemViewController.h
//  NextCare
//
//  Created by Omar Metwally on 10/26/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTodoItemViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
{
 
    __weak IBOutlet UILabel *caregiverLabel;
    
    __weak IBOutlet UILabel *patientIdLabel;
    
    __weak IBOutlet UILabel *descriptionLabel;
    
    __weak IBOutlet UITextField *caregiverIdField;
    
    __weak IBOutlet UITextField *patientIdField;
    __weak IBOutlet UITextView *descriptionTextView;
    __weak IBOutlet UIButton *saveButton;
}

- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)backgroundTouched:(id)sender;


@end
