//
//  MoodSelection+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSelection.h"

@interface MoodSelection (Create)

+ (MoodSelection *)createMoodSelection:(NSNumber *)r withTheta:(NSNumber *)theta inManagedObjectContext:(NSManagedObjectContext *)context;

@end
