//
//  todoCell.h
//  NextCare
//
//  Created by Omar Metwally on 10/26/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface todoCell : UITableViewCell
{

}
@property (weak, nonatomic) IBOutlet UIButton *smsButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedLabel;


@property (weak, nonatomic) IBOutlet UISwitch *completedSwitch;

-(void)smsButtonPressed:(UIButton *)sender;
-(void)switchChanged:(UISwitch *)senderSwitch;

@end
