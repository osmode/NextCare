//
//  NCToDoItem.h
//  NextCare
//
//  Created by Omar Metwally on 10/24/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCToDoItem : NSObject
{
    
}

typedef enum {
    TodoMedication,
    TodoLifestyle,
    TodoNutrition
} TodoType;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic) int completed;
@property (nonatomic, strong) NSString *responsibleParty;
@property (nonatomic) int todoType;
@property (nonatomic, strong) NSString *caregiverId;

@end
