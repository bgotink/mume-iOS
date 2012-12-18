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
+ (MoodPerson *)createMoodPersonWithFirstName:(NSString *)firstName
                                  andLastName:(NSString *)lastName
                  inManagedObjectContext:(NSManagedObjectContext *)context
{
    // Check whether a person with the name already exists in the database.
    NSArray *people = [MoodPerson queryMoodPersonWithFirstName:firstName
                                                   andLastName:lastName
                                        inManagedObjectContext:context];
    if (!people) {
        NSLog(@"Error occured while fetching from database");
        return nil;
    } else if (people.count > 0) {
        NSLog(@"Person with name: %@ %@ already exists in database, no new person is made.", firstName, lastName);
        return people[0];
    } else{
        NSLog(@"Creating Person with name: %@ %@", firstName, lastName);
        MoodPerson *person = [NSEntityDescription insertNewObjectForEntityForName:MOODPERSON_TABLE
                                                           inManagedObjectContext:context];
        person.firstName = firstName;
        person.lastName = lastName;
        return person;
    }
}

/* This method queries for a person with the given name in the database. */
+ (NSArray *)queryMoodPersonWithFirstName:(NSString *)firstName
                              andLastName:(NSString *)lastName
              inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODPERSON_TABLE];
    request.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@ %@", firstName, lastName];
    request.predicate = predicate;
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

@end
