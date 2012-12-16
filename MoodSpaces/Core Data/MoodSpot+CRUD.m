//
//  Location+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpot+CRUD.h"

@implementation MoodSpot (CRUD)

+ (MoodSpot *)createOrFetchMoodSpotWithName:(NSString *)name
                     inManagedObjectContext:(NSManagedObjectContext *)context
{
    MoodSpot *moodSpot;
    //Check whether a location with the location already exists in the database.
    NSArray *moodSpots = [MoodSpot queryMoodSpotWithName:name inManagedObjectContext:context];
    if (!moodSpots || (moodSpots.count > 1)) {
        NSLog(@"Error occured while fetching from database");
    } else if (moodSpots.count == 1) {
        NSLog(@"MoodSpot with name: %@ already exists in database, no new MoodSpot is made.", name);
        moodSpot = [moodSpots lastObject];
    } else {
        NSLog(@"Creating MoodSpot with name: %@", name);
        moodSpot = [NSEntityDescription insertNewObjectForEntityForName:MOODSPOT_ENTITY
                                                 inManagedObjectContext:context];
        [moodSpot setName:name];
    }
    return moodSpot;
}

+ (NSArray *)queryMoodSpotWithName:(NSString *)name
            inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODSPOT_ENTITY];
    request.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ == %@", MOODSPOT_NAME, name];
    request.predicate = predicate;
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

+ (NSArray *)queryAllInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODSPOT_ENTITY];
    request.predicate = [NSPredicate predicateWithFormat:@"%@ != ''", MOODSPOT_NAME];
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

@end
