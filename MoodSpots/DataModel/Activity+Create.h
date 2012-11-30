//
//  Activity+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "Activity.h"

@interface Activity (Create)

+ (Activity *)createActivity:(NSString *)activity inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)queryActivity:(NSString *)activity inManagedObjectContext:(NSManagedObjectContext *)context;
@end
