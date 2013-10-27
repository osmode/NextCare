//
//  PatientDetailViewController.h
//  NextCare
//
//  Created by Omar Metwally on 10/27/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientDetailViewController : UIViewController
{
    __weak IBOutlet UILabel *promptLabel;
    __weak IBOutlet UIButton *phoneButton;
    
}

@property (nonatomic, strong) NSString *currentPatientId;

- (IBAction)phoneButtonPressed:(id)sender;


@end
