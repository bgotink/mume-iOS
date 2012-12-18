//
//  UnmanagedMoodPerson.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 18/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface UnmanagedMoodPerson : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property int recordId;

@end
