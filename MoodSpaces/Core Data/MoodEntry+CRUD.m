//
//  MoodEntry+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodEntry+CRUD.h"


@implementation MoodEntry (CRUD)

/* Creates a mood entry with the given parameters. */
+ (MoodEntry *)createMoodEntryWithSelections:(NSSet *)moodSelections
                                        with:(NSSet *)moodPeeps
                                          at:(MoodSpot *)moodSpot
                                       doing:(MoodActivity *)moodActivity
                      inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSLog(@"Creating MoodEntry");
    //We dont check whether the same MoodEntry already exists because double are allowed.
    MoodEntry *entry;
    if (!entry) {
        entry = [NSEntityDescription insertNewObjectForEntityForName:MOODENTRY_ENTITY
                                              inManagedObjectContext:context];
        entry.date = [NSDate date];
        entry.feeling = moodSelections;
        entry.with = moodPeeps;
        entry.at = moodSpot;
        entry.doing = moodActivity;
    }
    return entry;
}

@end
