//
//  MoodEntry+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodEntry+Create.h"
#import "Log.h"

@implementation MoodEntry (Create)

/* Creates a mood entry with the given parameters. */
+ (MoodEntry *)createMoodEntryWithSelections:(NSSet *)moodSelections
                                        with:(NSSet *)moodPeeps
                                          at:(MoodSpot *)moodSpot
                                       doing:(MoodActivity *)moodActivity
                      inManagedObjectContext:(NSManagedObjectContext *)context
{
    MSLog(@"Creating MoodEntry");
    //We dont check whether the same MoodEntry already exists because double are allowed.
    MoodEntry *entry;
    if (!entry) {
        entry = [NSEntityDescription insertNewObjectForEntityForName:MOODENTRY_TABLE
                                              inManagedObjectContext:context];
        
        [entry setFeeling:moodSelections];
        [entry setWith:moodPeeps];
        [entry setAt:moodSpot];
        [entry setDoing:moodActivity];
    }
    return entry;
}

@end
