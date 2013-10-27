//
//  TeamListTableViewController.m
//  NextCare
//
//  Created by Omar Metwally on 10/26/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import "TeamListTableViewController.h"
#import "NCTeamDataStore.h"
#import "TeamCell.h"
#import "NCTeamMember.h"
#import "NewRelationshipViewController.h"

@interface TeamListTableViewController ()

@end

@implementation TeamListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newMember)];
        [[self navigationItem] setRightBarButtonItem:addButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"TeamCell" bundle:nil];
    // register this NIB
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TeamCell"];
    
    [[self navigationItem] setTitle:@"Team List"];


    
}

-(void)newMember
{
    NewRelationshipViewController *nrvc = [[NewRelationshipViewController alloc] init];
    [[self navigationController] pushViewController:nrvc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.

    NSLog(@"Number of team members: %lu", (unsigned long)[[[NCTeamDataStore sharedStore] teamMemberList] count] );
    
    return [[[NCTeamDataStore sharedStore] teamMemberList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TeamCell";
    
    TeamCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NCTeamMember *teamMember = [[[NCTeamDataStore sharedStore] teamMemberList] objectAtIndex:indexPath.row];
    NSLog(@"making cell with member: %@", teamMember.role);
    
    NSString *memberName = [teamMember name];
    NSString *memberRole = [teamMember role];
    
    [cell.nameLabel setText:memberName];
    [cell.roleLabel setText:memberRole];
    cell.roleLabel.textColor = [UIColor blueColor];
    
    if ( [[teamMember role] isEqualToString:@"physician"] ) {
        cell.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.2];
        [cell.avatarImageview setImage:[UIImage imageNamed:@"hibbert.png"]];
        
    } else if ( [[teamMember role] isEqualToString:@"patient"] ) {
        cell.backgroundColor = [UIColor colorWithRed:0.2 green:0.0 blue:1.0 alpha:0.2];
        [cell.avatarImageview setImage:[UIImage imageNamed:@"homer.png"]];
    } else if ( [[teamMember role] isEqualToString:@"caregiver"] ) {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.1];
        [cell.avatarImageview setImage:[UIImage imageNamed:@"marge.png"]];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.1 alpha:0.2];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
