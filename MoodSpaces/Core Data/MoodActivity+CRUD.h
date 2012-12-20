//
//  Activity+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodActivity.h"

static NSString *MOODACTIVITY_ENTITY = @"MoodActivity";
static NSString *MOODACTIVITY_NAME = @"name";

@interface MoodActivity (CRUD)

+ (MoodActivity *)createMoodActivityWithName:(NSString *)name
                      inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)queryMoodActivityWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)findAllInManagedObjectContext:(NSManagedObjectContext *)context;

@end
