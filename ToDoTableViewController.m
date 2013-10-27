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
#import "ServerOAuthController.h"

#define ROOT_PATH  @"http://162.243.36.210/"

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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
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
    NSLog(@"cellForRow");
    static NSString *CellIdentifier = @"todoCell";
    todoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NCToDoItem *todoItem = [[[NCTeamDataStore sharedStore] toDoList] objectAtIndex:indexPath.row];
    
    [cell.titleLabel setText:[todoItem title]];
    [cell.ownerLabel setText:[@"Supervisor: " stringByAppendingString:[todoItem responsibleParty]]];
    cell.ownerLabel.textColor = [UIColor blueColor];
    cell.smsButton.tag = indexPath.row;
    cell.emailButton.tag = indexPath.row;
    cell.completedSwitch.tag = indexPath.row;
    
    [cell.smsButton addTarget:self action:@selector(smsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [cell.emailButton addTarget:self action:@selector(emailButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [cell.completedSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];

    if ( [todoItem completed] > 0 ) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        cell.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.25];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;

}
-(void)switchChanged:(UISwitch *)switchIn
{
    int idx = switchIn.tag;
    
    NCToDoItem *todoItem = [[[NCTeamDataStore sharedStore] toDoList] objectAtIndex:idx];
    
    if (switchIn.on) {
        [self setItemCheck:idx state:1];
        [todoItem setCompleted:1];
        
    } else {
        [self setItemCheck:idx state:0];
        [todoItem setCompleted:0];
    }
    
    NSLog(@"xxx: %c", switchIn.on);
    [self.tableView reloadData];
}
/*
-(void)smsButtonPressed:(UIButton *)sender
{
    NSLog(@"smsButtonPressed at row: %li", (long)sender.tag);
}
*/
-(void)smsButtonPressed
{
    NSLog(@"sms button pressed");
}

-(void)emailButtonPressed
{
    NSLog(@"emailButtonPressed");
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0;
}

-(void)newTodoItem
{
    NewTodoItemViewController *ntivc = [[NewTodoItemViewController alloc] init];
    [[self navigationController] pushViewController:ntivc animated:YES];
}

-(void)setItemCheck:(int)index state:(int)newState
{
    NCToDoItem *todoItem = [[[NCTeamDataStore sharedStore] toDoList] objectAtIndex:index];
    
    NSString *patientId = [NSString stringWithFormat:@"%i",[[NCTeamDataStore sharedStore] userId]];
    NSString *message = [todoItem title];
    
    NSString *pathFirstHalf = @"todo/";
    NSString *pathLastHalf;
    if (newState == 0 ) {  // set to not checked
    pathLastHalf = @"/uncheck";
    } else {
        pathLastHalf = @"/check";
    }
    
    NSString *fullPath = [[pathFirstHalf stringByAppendingString:patientId] stringByAppendingString:pathLastHalf];
    
    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:fullPath parameters:moreParams HTTPmethod:@"POST" oauthToken:@"" oauthSecret:@""];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path238 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }
                                   
                               });
                           }];
    
}


@end
