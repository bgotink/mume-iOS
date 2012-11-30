//
//  Location+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "Location+Create.h"
#import "Log.h"

@implementation Location (Create)

+ (Location *)createLocation:(NSString *)location inManagedObjectContext:(NSManagedObjectContext *)context{
    //Check whether a location with the location already exists in the database.
    NSArray *locations = [Location queryLocation:location inManagedObjectContext:context];
    
    if(locations == nil){
        MSLog(@"Error occured while fetching from database");
        return nil;
    } else if(locations.count > 0){
        MSLog(@"Location with location: %@ already exists in database, no new activity is made.", location);
        return locations[0];
    } else{
        MSLog(@"Creating Location with location: %@", location);
        Location *newLocation = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
            [newLocation setLocation:location];
        return newLocation;
    }
}

+ (NSArray *)queryLocation:(NSString *)location inManagedObjectContext:(NSManagedObjectContext *)context{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    request.fetchBatchSize = 1;
    request.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"location = %@",location];
    request.predicate = predicate;
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

@end
