//
//  Location+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpot+CRUD.h"
#import "Log.h"

@implementation MoodSpot (Create)

+ (MoodSpot *)createMoodSpotWithName:(NSString *)name
                          atLatitude:(double)latitude
                         atLongitude:(double)longitude
              inManagedObjectContext:(NSManagedObjectContext *)context
{
    //Check whether a location with the location already exists in the database.
    NSArray *moodSpots = [MoodSpot queryMoodSpotWithName:name inManagedObjectContext:context];
    
    if (!moodSpots) {
        MSLog(@"Error occured while fetching from database");
        return nil;
    } else if (moodSpots.count > 0) {
        MSLog(@"MoodSpot with name: %@ already exists in database, no new MoodSpot is made.", name);
        return moodSpots[0];
    } else{
        MSLog(@"Creating MoodSpot with name: %@", name);
        MoodSpot *moodSpot = [NSEntityDescription insertNewObjectForEntityForName:MOODSPOT_TABLE
                                                           inManagedObjectContext:context];
        [moodSpot setName:name];
        [moodSpot setLatitude:[NSNumber numberWithDouble:latitude]];
        [moodSpot setLongitude:[NSNumber numberWithDouble:longitude]];
        return moodSpot;
    }
}

+ (NSArray *)queryMoodSpotWithName:(NSString *)name
            inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODSPOT_TABLE];
    request.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    request.predicate = predicate;
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

+ (NSArray *)findAllInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODSPOT_TABLE];
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

@end
