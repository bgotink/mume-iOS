//
//  MoodEntry+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodEntry.h"

@interface MoodEntry (Create)

+ (MoodEntry *)createMoodEntry:(NSSet *)closePeople at:(Location *)location withSelected:(NSSet *)selectedMoods doing:(Activity *)activity inManagedObjectContext:(NSManagedObjectContext *)context;

@end
