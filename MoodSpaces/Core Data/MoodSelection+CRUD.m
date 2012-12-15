//
//  MoodSelection+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSelection+CRUD.h"

@implementation MoodSelection (CRUD)

/* Creates a moodselection with the given polar coordinates. */
+ (MoodSelection *)createMoodSelection:(NSNumber *)r withTheta:(NSNumber *)theta inManagedObjectContext:(NSManagedObjectContext *)context{
    
    //Check whether a moodselection with the r and theta already exists in the database.
    //This check is not very useful because you are checking floats here, should be diff < 0.0001 or something in stead of one = other  
    /*NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MoodSelection"];
    request.fetchBatchSize = 1;
    request.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"r = %@ AND theta = %@",r, theta];
    request.predicate = predicate;
    NSError *error;
    NSArray *moodselections = [context executeFetchRequest:request error:&error];
    
    if(moodselections == nil){
        NSLog(@"Error occured while fetching from database: %@", error);
        return nil;
    } else if(moodselections.count > 0){
        NSLog(@"MoodSelection: (%@, %@) already exists in database, no new moodselection is made.", r, theta);
        return moodselections[0];
    } else{*/
        NSLog(@"Creating MoodSelection with elements: (%@, %@)", r, theta);
        MoodSelection *newSelection;
        newSelection = [NSEntityDescription insertNewObjectForEntityForName:@"MoodSelection"inManagedObjectContext:context];
        [newSelection setR:r];
        [newSelection setTheta:theta];
        return newSelection;
    //}
}

@end
