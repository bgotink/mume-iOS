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

+ (MoodPerson *)createMoodPersonWithName:(NSString *)name
                  inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)queryMoodPersonWithName:(NSString *)name
              inManagedObjectContext:(NSManagedObjectContext *)context;

@end
