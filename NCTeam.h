//
//  TeamInfoDataStore.h
//  NextCare
//
//  Created by Omar Metwally on 10/24/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCTeam : NSObject
{
    
}

@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, strong) NSMutableArray *providerList;
@property (nonatomic, strong) NSMutableArray *caregiverList;
@property (nonatomic, strong) NSMutableArray *toDoList;

@end

