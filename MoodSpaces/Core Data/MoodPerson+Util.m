//
//  MoodPerson+Util.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 18/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodPerson+Util.h"

@implementation MoodPerson (Util)

- (UnmanagedMoodPerson *)unmanagedCopy
{
    UnmanagedMoodPerson *person = [[UnmanagedMoodPerson alloc] init];
    person.lastName = self.lastName;
    person.firstName = self.firstName;
    person.recordId = [self.recordId intValue];
    return person;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
