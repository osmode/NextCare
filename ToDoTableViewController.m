//
//  ToDoTableViewController.m
//  NextCare
//
//  Created by Omar Metwally on 10/26/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "NCTeamDataStore.h"
#import "NCToDoItem.h"
#import "todoCell.h"
#import "NewTodoItemViewController.h"

@interface ToDoTableViewController ()

@end

@implementation ToDoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newTodoItem)];
        [[self navigationItem] setRightBarButtonItem:addButton];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // load the custom cell XIB file
    UINib *nib = [UINib nibWithNibName:@"todoCell" bundle:nil];
    // register this NIB
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"todoCell"];
    [[self navigationItem] setTitle:@"Todo list"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    // Return the number of rows in the section.
    int numberOfRows = [[[NCTeamDataStore sharedStore] toDoList] count];
    NSLog(@"numberOfRows: %i", numberOfRows);
    
    return [[[NCTeamDataStore sharedStore] toDoList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"todoCell";
    todoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NCToDoItem *todoItem = [[[NCTeamDataStore sharedStore] toDoList] objectAtIndex:indexPath.row];
    
    [cell.titleLabel setText:[todoItem title]];
    [cell.ownerLabel setText:[@"Supervisor: " stringByAppendingString:[todoItem responsibleParty]]];
    cell.ownerLabel.textColor = [UIColor blueColor];

    if ( [todoItem completed] > 0 ) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        cell.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.25];
    }
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

-(void)newTodoItem
{
    NewTodoItemViewController *ntivc = [[NewTodoItemViewController alloc] init];
    [[self navigationController] pushViewController:ntivc animated:YES];
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
