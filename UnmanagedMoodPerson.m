//
//  UnmanagedMoodPerson.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 18/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "UnmanagedMoodPerson.h"

@implementation UnmanagedMoodPerson

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize recordId = _recordId;

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
