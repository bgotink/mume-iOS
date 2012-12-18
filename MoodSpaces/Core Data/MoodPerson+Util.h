//
//  MoodPerson+Util.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 18/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodPerson.h"
#import "UnmanagedMoodPerson.h"

@interface MoodPerson (Util)

- (UnmanagedMoodPerson *)unmanagedCopy;
- (NSString *)description;

@end
