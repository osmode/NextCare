//
//  NCTeamDataStore.m
//  NextCare
//
//  Created by Omar Metwally on 10/25/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import "NCTeamDataStore.h"
#import "ServerOAuthController.h"
#import "NCToDoItem.h"
#import "NCTeamMember.h"

#define ROOT_PATH   @"http://162.243.36.210/"

@implementation NCTeamDataStore
@synthesize sections, teamArray, teamMemberList, toDoList, userId, userToken;
@synthesize role;

+(NCTeamDataStore *)sharedStore
{
    //a static variable is initialized only once
    static NCTeamDataStore *sharedStore = nil;

    
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

-(id)init
{
    self = [super init];
    if (self) {
        NSString *path = [self itemArchivePath];
        
        sections = [[NSMutableArray alloc] initWithObjects:@"Team Members", @"To do list", nil];
        
        teamArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        toDoList = [NSMutableArray array];
        teamMemberList = [NSMutableArray array];
        
    }
    return self;
}

-(NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get the one and only document directory
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"team.archive"];
    
}

-(void)loadDefaultParameters
{
    
}

-(void)addTodoItem:(NCToDoItem *)item
{
    [[[NCTeamDataStore sharedStore] toDoList] addObject:item];
}
-(void)populateToDoList:(NSString *)userId
{
    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    /*
    [moreParams setValue:emailTextField.text forKey:@"email"];
    [moreParams setValue:passwordTextField.text forKey:@"password"];
    */
    
    NSLog(@"userId: %@", userId);
    NSString *firstPart = @"user/";
    
    NSString *lastPart = @"/todos";
    NSMutableString *fullPath = [[firstPart stringByAppendingString:userId] stringByAppendingString:lastPart];
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:fullPath parameters:moreParams HTTPmethod:@"GET" oauthToken:@"" oauthSecret:@""];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path35 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }
                                   
                                   NSArray *a = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
                                   NSArray *a2 = [a objectAtIndex:1];
                                   
                                   // iterate through array of dictionaries
                                   for (NSDictionary *d in a2) {
                                       NSString *title = [d valueForKey:@"description"];
                                       NSString *owner = [d valueForKey:@"caregiver_name"];
                                       NSNumber *caregiverIdNumber = [d valueForKey:@"caregiver_id"];
                                       NSString *caregiverId = [caregiverIdNumber stringValue];
                                       
                                       NSNumber *complete = [d valueForKey:@"complete"];
                                       
                                       NSString *type = [d valueForKey:@"type"];

                                       NCToDoItem *newTodo = [[NCToDoItem alloc] init];
                                       [newTodo setTitle:title];
                                       [newTodo setResponsibleParty:owner];
                                       [newTodo setCompleted:[complete intValue]];
                                       [newTodo setCaregiverId:caregiverId];
                                       [newTodo setType:type];
                                       
                                       NSLog(@"type: %@", type);
                                    
                                       [[[NCTeamDataStore sharedStore] toDoList] addObject:newTodo];
                                        
                                   }
            
                                   NSLog(@"length of todo list: %lu", (unsigned long)[[[NCTeamDataStore sharedStore] toDoList] count]);
                               });
                           }];
    
}

-(BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:toDoList toFile:path];
}

-(void)populatePatientCaregiverTeam:(NSString *)userId
{
    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    /*
     [moreParams setValue:emailTextField.text forKey:@"email"];
     [moreParams setValue:passwordTextField.text forKey:@"password"];
     */
    
    NSString *firstPart = @"user/";
    
    NSString *lastPart = @"/caregivers";
    NSMutableString *fullPath = [[firstPart stringByAppendingString:userId] stringByAppendingString:lastPart];
    
    NSLog(@"full todo list path: %@", fullPath);
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:fullPath parameters:moreParams HTTPmethod:@"GET" oauthToken:@"" oauthSecret:@""];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path35 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }
                                   
                                   NSArray *a = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
                                   NSArray *a2 = [a objectAtIndex:1];
                                   
                                   // iterate through array of dictionaries
                                   for (NSDictionary *d in a2) {
                                       NSNumber *idNumber = [d valueForKey:@"id"];
                                       NSString *name = [d valueForKey:@"name"];
                                       NSString *type = [d valueForKey:@"type"];
                                       NSString *email = [d valueForKey:@"email"];
                                       NSString *phone = [d valueForKey:@"phone"];
                                       NSString *code = [d valueForKey:@"code"];
                                       
                                       NSString *relativePath = [d valueForKey:@"avatar"];
                                       
                                       NSString *fullAvatarPath = [ROOT_PATH stringByAppendingString:relativePath];
                                       
                                       NCTeamMember *teamMember = [[NCTeamMember alloc] init];
                                       
                                       [teamMember setName:name];
                                       [teamMember setRole:type];
                                       [teamMember setEmail:email];
                                       [teamMember setPhone:phone];
                                       [teamMember setCode:code];
                                       [teamMember setIdNumber:[idNumber intValue]];
                                       
                                       [teamMember setAvatarPath:fullAvatarPath];
                                       
                                       NSLog(@"fullAvatarPath: %@", fullAvatarPath);

                                       [[[NCTeamDataStore sharedStore] teamMemberList] addObject:teamMember];
                                       
                                       
                                   }
                                   
                               });
                           }];
}

-(void)populatePhysiciansPatients:(NSString *)userId
{
    NSLog(@"populatePhysiciansPatients");
    
    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    /*
     [moreParams setValue:emailTextField.text forKey:@"email"];
     [moreParams setValue:passwordTextField.text forKey:@"password"];
     */
    
    NSString *firstPart = @"user/";
    
    NSString *lastPart = @"/patients";
    NSMutableString *fullPath = [[firstPart stringByAppendingString:userId] stringByAppendingString:lastPart];
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:fullPath parameters:moreParams HTTPmethod:@"GET" oauthToken:@"" oauthSecret:@""];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path35 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }
                                   
                                   NSArray *a = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
                                   NSArray *a2 = [a objectAtIndex:1];
                                   
                                   // iterate through array of dictionaries
                                   for (NSDictionary *d in a2) {
                                       NSNumber *idNumber = [d valueForKey:@"id"];
                                       NSString *name = [d valueForKey:@"name"];
                                       NSString *type = [d valueForKey:@"type"];
                                       NSString *email = [d valueForKey:@"email"];
                                       NSString *phone = [d valueForKey:@"phone"];
                                       NSString *code = [d valueForKey:@"code"];
                                       
                                       NSString *relativePath = [d valueForKey:@"avatar"];
                                       
                                       NSString *fullAvatarPath = [ROOT_PATH stringByAppendingString:relativePath];
                                       
                                       NCTeamMember *teamMember = [[NCTeamMember alloc] init];
                                       
                                       [teamMember setName:name];
                                       [teamMember setRole:type];
                                       [teamMember setEmail:email];
                                       [teamMember setPhone:phone];
                                       [teamMember setCode:code];
                                       [teamMember setIdNumber:[idNumber intValue]];
                                       [teamMember setAvatarPath:fullAvatarPath];
                                       
                                       NSLog(@"fullAvatarPath: %@", fullAvatarPath);
                                       
                                       [[[NCTeamDataStore sharedStore] teamMemberList] addObject:teamMember];
                                       
                                   }
                                                                      
                                   NSLog(@"right after adding: %lu", (unsigned long)[[[NCTeamDataStore sharedStore] teamMemberList] count]);

                               });
                           }];
}



@end
