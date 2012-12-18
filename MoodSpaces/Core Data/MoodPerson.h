//
//  MoodPerson.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 18/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MoodEntry;

@interface MoodPerson : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * recordId;
@property (nonatomic, retain) NSSet *in;
@end

@interface MoodPerson (CoreDataGeneratedAccessors)

- (void)addInObject:(MoodEntry *)value;
- (void)removeInObject:(MoodEntry *)value;
- (void)addIn:(NSSet *)values;
- (void)removeIn:(NSSet *)values;

@end
