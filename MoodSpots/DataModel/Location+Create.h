//
//  Location+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "Location.h"

@interface Location (Create)

+ (Location *)createLocation:(NSString *)location inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)queryLocation:(NSString *)location inManagedObjectContext:(NSManagedObjectContext *)context;

@end
