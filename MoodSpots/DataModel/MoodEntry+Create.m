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
+ (MoodEntry *)createMoodEntry:(NSSet *)closePeople at:(Location *)location withSelected:(NSSet *)selectedMoods doing:(Activity *)activity inManagedObjectContext:(NSManagedObjectContext *)context{
    MSLog(@"Creating MoodEntry");
    //We dont check whether the same MoodEntry already exists because double are allowed.
    MoodEntry *newEntry;
    if(!newEntry){
        
        newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"MoodEntry" inManagedObjectContext:context];
        [newEntry setClosePersons:closePeople];
        [newEntry setFromWhere:location];
        [newEntry setSelectedMoods:selectedMoods];
        [newEntry setWhichActivity:activity];
    }
    return newEntry;
}

@end
