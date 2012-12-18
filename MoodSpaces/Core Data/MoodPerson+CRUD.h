//
//  Person+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodPerson.h"

static NSString *MOODPERSON_TABLE = @"MoodPerson";

@interface MoodPerson (CRUD)

+ (MoodPerson *)createMoodPersonWithFirstName:(NSString *)firstName
                                  andLastName:(NSString *)lastName
                       inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)queryMoodPersonWithFirstName:(NSString *)firstName
                              andLastName:(NSString *)lastName
                   inManagedObjectContext:(NSManagedObjectContext *)context;

@end
