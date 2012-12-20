//
//  Person+Create.h
//  MoodSpots
//
//  Created by Thypo on 11/26/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodPerson.h"
#import "UnmanagedMoodPerson.h"
#import <AddressBook/AddressBook.h>

static NSString *MOODPERSON_ENTITY = @"MoodPerson";
static NSString *MOODPERSON_RECORD_ID = @"recordId";
static NSString *MOODPERSON_FIRST_NAME = @"firstName";
static NSString *MOODPERSON_LAST_NAME = @"lastName";

@interface MoodPerson (CRUD)

+ (MoodPerson *)findByRecordID:(ABRecordID)recordId
        inManagedObjectContext:(NSManagedObjectContext *)context;

+ (MoodPerson *)moodPersonWithUnmanagedMoodPerson:(UnmanagedMoodPerson *)person
                           inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)findAllInManagedObjectContext:(NSManagedObjectContext *)context;

@end
