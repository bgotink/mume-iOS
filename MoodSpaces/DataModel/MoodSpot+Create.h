//
//  Location+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpot.h"

static NSString *MOODSPOT_TABLE = @"MoodSpot";

@interface MoodSpot (Create)

+ (MoodSpot *)createMoodSpotWithName:(NSString *)name
                          atLatitude:(double)latitude
                         atLongitude:(double)longitude
              inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)queryMoodSpotWithName:(NSString *)name
            inManagedObjectContext:(NSManagedObjectContext *)context;

@end
