//
//  Person+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "Person.h"

@interface Person (Create)

+ (Person *)createPerson:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)queryPerson:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end
