//
//  Activity+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodActivity+Create.h"
#import "Log.h"

@implementation MoodActivity (Create)

/* Creates an activity with the given name if it doesn't already exits in the database. */
+ (MoodActivity *)createMoodActivityWithName:(NSString *)name
                      inManagedObjectContext:(NSManagedObjectContext *)context
{
    
    //Check whether a activity with the activity already exists in the database.
    NSArray *activities = [MoodActivity queryMoodActivityWithName:name
                                           inManagedObjectContext:context];
    
    if (!activities) {
        MSLog(@"Error occured while fetching from database");
        return nil;
    } else if (activities.count > 0) {
        MSLog(@"MoodActivity with name: %@ already exists in database, no new MoodActivity is made.", name);
        return activities[0];
    } else {
        MSLog(@"Creating Activity with activity: %@", name);
        MoodActivity *activity = [NSEntityDescription insertNewObjectForEntityForName:MOODACTIVITY_TABLE
                                                               inManagedObjectContext:context];
        [activity setName:name];
        return activity;
    }
}

/* Query for an activity with the given name in the database. */
+ (NSArray *)queryMoodActivityWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODACTIVITY_TABLE];
    request.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    request.predicate = predicate;
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

@end
