//
//  MoodEntry.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 12/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MoodActivity, MoodPerson, MoodSelection, MoodSpot;

@interface MoodEntry : NSManagedObject

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSSet *with;
@property (nonatomic, retain) MoodSpot *at;
@property (nonatomic, retain) NSSet *feeling;
@property (nonatomic, retain) MoodActivity *doing;
@end

@interface MoodEntry (CoreDataGeneratedAccessors)

- (void)addWithObject:(MoodPerson *)value;
- (void)removeWithObject:(MoodPerson *)value;
- (void)addWith:(NSSet *)values;
- (void)removeWith:(NSSet *)values;

- (void)addFeelingObject:(MoodSelection *)value;
- (void)removeFeelingObject:(MoodSelection *)value;
- (void)addFeeling:(NSSet *)values;
- (void)removeFeeling:(NSSet *)values;

@end
