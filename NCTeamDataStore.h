//
//  NCTeamDataStore.h
//  NextCare
//
//  Created by Omar Metwally on 10/25/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NCTeamDataStore, NCToDoItem;
@interface NCTeamDataStore : NSObject
{

}

@property (nonatomic, copy) NSMutableArray *sections;
@property (nonatomic, copy) NSMutableArray *teamMemberList;
@property (nonatomic, strong) NSMutableArray *toDoList;
@property (nonatomic, copy) NSMutableArray *teamArray;
@property (nonatomic) int userId;
@property (nonatomic, strong) NSString *userToken;
@property (nonatomic, strong) NSString *role, *email, *phone, *code;

//used to create sections; populated with dictionaries,
//a dictionary for each section

+ (NCTeamDataStore *)sharedStore;
-(NSString *)itemArchivePath;
-(void)populateToDoList:(NSString *)userId;
-(void)populatePatientCaregiverTeam:(NSString *)userId;
-(void)addTodoItem:(NCToDoItem *)item;
-(BOOL)saveChanges;


@end


