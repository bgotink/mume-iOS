//
//  Activity+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "Activity+Create.h"
#import "Log.h"

@implementation Activity (Create)

/* Creates an activity with the given name if it doesn't already exits in the database. */
+ (Activity *)createActivity:(NSString *)activity inManagedObjectContext:(NSManagedObjectContext *)context{
    
    //Check whether a activity with the activity already exists in the database.
    NSArray *activities = [Activity queryActivity:activity inManagedObjectContext:context];
    
    if(activities == nil){
        MSLog(@"Error occured while fetching from database");
        return nil;
    } else if(activities.count > 0){
        MSLog(@"Activity with activity: %@ already exists in database, no new activity is made.", activity);
        return activities[0];
    } else{
        MSLog(@"Creating Activity with activity: %@", activity);
        Activity *newActivity = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:context];
        [newActivity setActivity:activity];
        return newActivity;
    }
}

/* Query for an activity with the given name in the database. */
+ (NSArray *)queryActivity:(NSString *)activity inManagedObjectContext:(NSManagedObjectContext *)context{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Activity"];
    request.fetchBatchSize = 1;
    request.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"activity = %@",activity];
    request.predicate = predicate;
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

@end
