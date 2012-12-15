//
//  Person+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodPerson+CRUD.h"

@implementation MoodPerson (CRUD)

/* Creates a person with the given name in the database if a person with this name didn't already exist in the database. */
+ (MoodPerson *)createMoodPersonWithName:(NSString *)name
                  inManagedObjectContext:(NSManagedObjectContext *)context
{
    // Check whether a person with the name already exists in the database.
    NSArray *people = [MoodPerson queryMoodPersonWithName:name inManagedObjectContext:context];
    if (!people) {
        NSLog(@"Error occured while fetching from database");
        return nil;
    } else if (people.count > 0) {
        NSLog(@"Person with name: %@ already exists in database, no new person is made.", name);
        return people[0];
    } else{
        NSLog(@"Creating Person with name: %@", name);
        MoodPerson *person = [NSEntityDescription insertNewObjectForEntityForName:MOODPERSON_TABLE
                                                           inManagedObjectContext:context];
        [person setName:name];
        return person;
    }
}

/* This method queries for a person with the given name in the database. */
+ (NSArray *)queryMoodPersonWithName:(NSString *)name
              inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODPERSON_TABLE];
    request.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    request.predicate = predicate;
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

@end
