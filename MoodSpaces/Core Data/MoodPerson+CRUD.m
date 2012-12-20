//
//  Person+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodPerson+CRUD.h"

@implementation MoodPerson (CRUD)

+ (MoodPerson *)findByRecordID:(ABRecordID)recordId
        inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODPERSON_ENTITY];
    request.predicate = [NSPredicate predicateWithFormat:@"%@ = %d", MOODPERSON_RECORD_ID, recordId];
    request.fetchLimit = 1;
    NSError *error = nil;
    NSArray *people = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Got error %@", error);
        return nil;
    } else {
        return [people lastObject];
    }
}

+ (MoodPerson *)moodPersonWithUnmanagedMoodPerson:(UnmanagedMoodPerson *)person
                           inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSLog(@"Fetching %@", person);
    MoodPerson *moodPerson = [MoodPerson findByRecordID:person.recordId
                                 inManagedObjectContext:context];
    NSLog(@"Fetched MoodPerson = %@", moodPerson);
    if (!moodPerson) {
        moodPerson = [NSEntityDescription insertNewObjectForEntityForName:MOODPERSON_ENTITY
                                                   inManagedObjectContext:context];
    }
    moodPerson.recordId = [NSNumber numberWithInt:person.recordId];
    moodPerson.firstName = person.firstName;
    moodPerson.lastName = person.lastName;
    return moodPerson;
}

+ (NSArray *)findAllInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MOODPERSON_ENTITY];
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error while fetching: %@", error);
    }
    return result;
}

@end
