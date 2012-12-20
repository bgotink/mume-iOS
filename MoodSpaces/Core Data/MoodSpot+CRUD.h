//
//  Location+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpot+Util.h"

static NSString *MOODSPOT_ENTITY = @"MoodSpot";
static NSString *MOODSPOT_NAME = @"name";
static NSString *MOODSPOT_LATITUDE = @"latitude";
static NSString *MOODSPOT_LONGITUDE = @"longitude";

@interface MoodSpot (CRUD)

+ (MoodSpot *)createOrFetchMoodSpotWithName:(NSString *)name
                     inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)queryMoodSpotWithName:(NSString *)name
            inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)queryAllInManagedObjectContext:(NSManagedObjectContext *)context;

@end
