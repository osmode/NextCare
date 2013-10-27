//
//  todoCell.m
//  NextCare
//
//  Created by Omar Metwally on 10/26/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import "todoCell.h"
#import "NCTeamDataStore.h"
#import "NCToDoItem.h"
#import "ServerOAuthController.h"


@implementation todoCell
@synthesize smsButton, emailButton, completedSwitch, completedLabel;

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)smsButtonPressed:(UIButton *)sender
{
    NSLog(@"smsButtonPressed! %i", sender.tag);
    [self sendSms:sender.tag];
}

-(void)emailButtonPressed:(UIButton *)sender
{
    NSLog(@"emailButtonPressed! %i", sender.tag);
    [self sendEmail:sender.tag];
}

-(void)sendSms:(int)index
{

    NCToDoItem *todoItem = [[[NCTeamDataStore sharedStore] toDoList] objectAtIndex:index];
    
    NSString *caregiverId = [todoItem caregiverId];
    NSString *message = [todoItem title];
    
    NSString *pathFirstHalf = @"user/";
    NSString *pathLastHalf = @"/remind";
    NSString *fullPath = [[pathFirstHalf stringByAppendingString:caregiverId] stringByAppendingString:pathLastHalf];
    
    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    [moreParams setValue:message forKey:@"message"];
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:fullPath parameters:moreParams HTTPmethod:@"POST" oauthToken:@"" oauthSecret:@""];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path47 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }

                                   
                               });
                           }];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"SMS reminder successfully sent!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];

}

-(void)sendEmail:(int)index
{

    NCToDoItem *todoItem = [[[NCTeamDataStore sharedStore] toDoList] objectAtIndex:index];
    
    NSString *caregiverId = [todoItem caregiverId];
    NSString *message = [todoItem title];
    
    NSString *pathFirstHalf = @"user/";
    NSString *pathLastHalf = @"/email";
    NSString *fullPath = [[pathFirstHalf stringByAppendingString:caregiverId] stringByAppendingString:pathLastHalf];
    
    NSMutableDictionary *moreParams = [[NSMutableDictionary alloc] init];
    [moreParams setValue:message forKey:@"message"];
    
    NSURLRequest *request = [ServerOAuthController preparedRequestForPath:fullPath parameters:moreParams HTTPmethod:@"POST" oauthToken:@"" oauthSecret:@""];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:NSOperationQueue.mainQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   NSLog(@"path42 %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                   
                                   if (error) {
                                       
                                       NSLog(@"Error in API request: %@", error.localizedDescription);
                                       return;
                                   }
                                   
                               });
                           }];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Email reminder successfully sent!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
    
}

-(void)switchChanged:(UISwitch *)senderSwitch
{
    
    
}


@end
