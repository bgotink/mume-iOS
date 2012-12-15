//
//  MoodEntry+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodEntry.h"

static NSString *MOODENTRY_TABLE = @"MoodEntry";

@interface MoodEntry (CRUD)

+ (MoodEntry *)createMoodEntryWithSelections:(NSSet *)moodSelections
                                        with:(NSSet *)moodPeeps
                                          at:(MoodSpot *)moodSpot
                                       doing:(MoodActivity *)moodActivity
                      inManagedObjectContext:(NSManagedObjectContext *)context;

@end