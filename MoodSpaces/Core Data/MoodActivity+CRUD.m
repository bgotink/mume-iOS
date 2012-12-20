//
//  Activity+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodActivity+CRUD.h"

@implementation MoodActivity (CRUD)

/* Creates an activity with the given name if it doesn't already exits in the database. */
+ (MoodActivity *)createMoodActivityWithName:(NSString *)name
                      inManagedObjectContext:(NSManagedObjectContext *)context
{
    MoodActivity *moodActivity;
    //Check whether a location with the location already exists in the database.
    NSArray *activities = [MoodActivity queryMoodActivityWithName:name inManagedObjectContext:context];
    if (!activities || (activities.count > 1)) {
        NSLog(@"Error occured while fetching from database");
    } else if (activities.count == 1) {
        NSLog(@"MoodActivity with name: %@ already exists in database, no new MoodActivity is made.", name);
        moodActivity = [activities lastObject];
    } else {
        NSLog(@"Creating MoodActivity with name: %@", name);
        moodActivity = [NSEntityDescription insertNewObjectForEntityForName:MOODACTIVITY_ENTITY
                                                 inManagedObjectContext:context];
        moodActivity.name = name;
    }
    return moodActivity;
}

/* Query for an activity with the given name in the database. */
+ (NSArray *)queryMoodActivityWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODACTIVITY_ENTITY];
    request.predicate = [NSPredicate predicateWithFormat:@"%@ == %@", MOODACTIVITY_NAME, name];
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

+ (NSArray *)findAllInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODACTIVITY_ENTITY];
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error while fetching: %@", error);
    }
    return result;
}

@end
