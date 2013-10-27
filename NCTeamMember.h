//
//  NCTeamMember.h
//  NextCare
//
//  Created by Omar Metwally on 10/26/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCTeamMember : NSObject
{
    
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email, *phone, *role, *code;
@property (nonatomic) int idNumber;
@property (nonatomic, strong) NSString *avatarPath;

@end
