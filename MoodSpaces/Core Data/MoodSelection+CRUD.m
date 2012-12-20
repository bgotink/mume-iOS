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
+ (MoodSelection *)moodSelectionWithPolarCoordinate:(PolarCoordinate *)coordinate
                             inManagedObjectContext:(NSManagedObjectContext *)context;
{
    MoodSelection *selection = [NSEntityDescription insertNewObjectForEntityForName:MOODSELECTION_ENTITY
                                                             inManagedObjectContext:context];
    selection.r = [NSNumber numberWithFloat:coordinate.r];
    selection.theta = [NSNumber numberWithFloat:coordinate.theta];
    return selection;
}

@end
