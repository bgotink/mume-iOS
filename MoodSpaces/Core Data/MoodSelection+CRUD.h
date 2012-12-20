//
//  MoodSelection+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSelection.h"
#import "PolarCoordinate.h"

static NSString *MOODSELECTION_ENTITY = @"MoodSelection";
static NSString *MOODSELECTION_R = @"r";
static NSString *MOODSELECTION_THETA = @"theta";

@interface MoodSelection (CRUD)

+ (MoodSelection *)moodSelectionWithPolarCoordinate:(PolarCoordinate *)coordinate
                             inManagedObjectContext:(NSManagedObjectContext *)context;

@end
