//
//  MoodEntry.h
//  MoodSpots
//
//  Created by Thypo on 11/25/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MoodSelection, Person;

@interface MoodEntry : NSManagedObject

@property (nonatomic, retain) NSString * activity;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSSet *closePersons;
@property (nonatomic, retain) NSSet *selectedMoods;
@end

@interface MoodEntry (CoreDataGeneratedAccessors)

- (void)addClosePersonsObject:(Person *)value;
- (void)removeClosePersonsObject:(Person *)value;
- (void)addClosePersons:(NSSet *)values;
- (void)removeClosePersons:(NSSet *)values;

- (void)addSelectedMoodsObject:(MoodSelection *)value;
- (void)removeSelectedMoodsObject:(MoodSelection *)value;
- (void)addSelectedMoods:(NSSet *)values;
- (void)removeSelectedMoods:(NSSet *)values;

@end
