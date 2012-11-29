//
//  Person+Create.m
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "Person+Create.h"
#import "Log.h"

@implementation Person (Create)

+ (Person *)createPerson:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context{
    //Check whether a person with the name already exists in the database.
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    request.fetchBatchSize = 1;
    request.fetchLimit = 1;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
    request.predicate = predicate;
    NSError *error;
    NSArray *persons = [context executeFetchRequest:request error:&error];
    
    if(persons == nil){
        MSLog(@"Error occured while fetching from database: %@", error);
        return nil;
    } else if(persons.count > 0){
        MSLog(@"Person with name: %@ already exists in database, no new person is made.", name);
        return persons[0];
    } else{
        MSLog(@"Creating Person with name: %@", name);
        Person *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
        [newPerson setName:name];
        return newPerson;
    }
}

+ (NSArray *)queryPerson:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    request.fetchBatchSize = 20;
    request.fetchLimit = 100;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
    request.predicate = predicate;
    NSError *error;
    return [context executeFetchRequest:request error:&error];
}

@end
